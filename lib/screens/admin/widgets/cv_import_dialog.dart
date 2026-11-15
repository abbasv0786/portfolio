import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../services/cv_data_transfer.dart';
import '../../../services/firestore_service.dart';
import '../../../services/json_file/json_file.dart';

/// Paste or pick an exported CV-data JSON file, preview what it changes,
/// then write it to Firestore. Pops with `true` once applied.
class CvImportDialog extends StatefulWidget {
  const CvImportDialog({super.key});

  @override
  State<CvImportDialog> createState() => _CvImportDialogState();
}

class _CvImportDialogState extends State<CvImportDialog> {
  final _jsonController = TextEditingController();
  CvImportPlan? _plan;
  String? _error;
  bool _applying = false;

  @override
  void dispose() {
    _jsonController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final text = await pickJsonFile();
    if (text == null) return;
    _jsonController.text = text;
    _preview();
  }

  void _preview() {
    final fs = FirestoreService.to;
    try {
      final plan = CvDataTransfer.plan(
        _jsonController.text,
        currentProjects: fs.projects,
        currentSkills: fs.techCategories,
        currentExperiences: fs.experiences,
        currentProfile: fs.profileInfo.value,
      );
      setState(() {
        _plan = plan;
        _error = null;
      });
    } on FormatException catch (e) {
      setState(() {
        _plan = null;
        _error = e.message;
      });
    }
  }

  Future<void> _apply() async {
    final plan = _plan;
    if (plan == null || !plan.hasChanges) return;
    setState(() => _applying = true);
    try {
      await FirestoreService.to.applyCvImport(plan);
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        setState(() {
          _applying = false;
          _error = 'Saving to Firestore failed: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final plan = _plan;
    return Dialog(
      backgroundColor: AppColors.backgroundCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640, maxHeight: 720),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.file_upload_outlined,
                      color: AppColors.accent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      plan == null ? 'Import CV Data' : 'Review changes',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary),
                    ),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.close, color: AppColors.textSecondary),
                    onPressed: _applying
                        ? null
                        : () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
              const Divider(color: AppColors.glassBorder),
              const SizedBox(height: 8),
              Expanded(
                  child: plan == null ? _buildInput() : _buildPreview(plan)),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(_error!,
                    style:
                        const TextStyle(color: Colors.redAccent, fontSize: 13)),
              ],
              const SizedBox(height: 16),
              _buildActions(plan),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Load a file exported from here (and tailored for a job). Only the '
          'profile summary, experience, projects and skills in the file are '
          'changed; nothing is deleted. '
          'Tip: export first to keep a backup of your current version.',
          style: TextStyle(
              fontSize: 13, color: AppColors.textSecondary, height: 1.4),
        ),
        const SizedBox(height: 12),
        if (canPickJsonFile) ...[
          OutlinedButton.icon(
            onPressed: _pickFile,
            icon: const Icon(Icons.folder_open_rounded, size: 18),
            label: const Text('Choose JSON file'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.accent,
              side: const BorderSide(color: AppColors.accent),
            ),
          ),
          const SizedBox(height: 12),
          const Text('…or paste the JSON:',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 6),
        ],
        Expanded(
          child: TextField(
            controller: _jsonController,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontFamily: 'monospace'),
            decoration: InputDecoration(
              hintText: '{ "format": "portfolio-cv-data", "projects": [...] }',
              hintStyle: TextStyle(
                  color: AppColors.textSecondary.withValues(alpha: 0.5)),
              filled: true,
              fillColor: AppColors.background.withValues(alpha: 0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.glassBorder),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreview(CvImportPlan plan) {
    if (!plan.hasChanges) {
      return const Center(
        child: Text('This file matches your current data — nothing to change.',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    return ListView(
      children: [
        if (plan.profile != null) ...[
          ..._section('Profile', [plan.profile!]),
          const SizedBox(height: 12),
        ],
        ..._section('Experience', plan.experiences),
        const SizedBox(height: 12),
        ..._section('Projects', plan.projects),
        const SizedBox(height: 12),
        ..._section('Skill categories', plan.skills),
      ],
    );
  }

  List<Widget> _section<T>(String title, List<ItemChange<T>> changes) {
    if (changes.isEmpty) return const [];
    final unchanged =
        changes.where((c) => c.kind == ChangeKind.unchanged).length;
    return [
      Text(title,
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary)),
      const SizedBox(height: 6),
      for (final c in changes.where((c) => c.kind != ChangeKind.unchanged))
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _badge(c.kind),
              const SizedBox(width: 10),
              Expanded(
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: c.label,
                        style: const TextStyle(color: AppColors.textPrimary)),
                    if (c.changedFields.isNotEmpty)
                      TextSpan(
                          text: '  ·  ${c.changedFields.join(', ')}',
                          style:
                              const TextStyle(color: AppColors.textSecondary)),
                  ]),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      if (unchanged > 0)
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text('$unchanged unchanged',
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textSecondary)),
        ),
    ];
  }

  Widget _badge(ChangeKind kind) {
    final isNew = kind == ChangeKind.added;
    final color = isNew ? const Color(0xFF64FFDA) : const Color(0xFFFFD700);
    return Container(
      width: 64,
      padding: const EdgeInsets.symmetric(vertical: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(isNew ? 'New' : 'Updated',
          style: TextStyle(
              fontSize: 11, color: color, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildActions(CvImportPlan? plan) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (plan != null)
          TextButton(
            onPressed: _applying ? null : () => setState(() => _plan = null),
            child: const Text('Back',
                style: TextStyle(color: AppColors.textSecondary)),
          )
        else
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: plan == null
              ? _preview
              : (plan.hasChanges && !_applying ? _apply : null),
          icon: _applying
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.black))
              : Icon(plan == null ? Icons.preview_rounded : Icons.check_rounded,
                  size: 18),
          label: Text(
            plan == null
                ? 'Preview changes'
                : _applying
                    ? 'Saving...'
                    : 'Apply ${plan.changeCount} change${plan.changeCount == 1 ? '' : 's'}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ],
    );
  }
}
