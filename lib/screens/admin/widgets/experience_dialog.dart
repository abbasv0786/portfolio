import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../models/experience.dart';

class ExperienceDialog extends StatefulWidget {
  final Experience? experience;
  final Function(Experience) onSave;

  const ExperienceDialog({
    super.key,
    this.experience,
    required this.onSave,
  });

  @override
  State<ExperienceDialog> createState() => _ExperienceDialogState();
}

class _ExperienceDialogState extends State<ExperienceDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _companyController;
  late TextEditingController _positionController;
  late TextEditingController _durationController;
  late TextEditingController _locationController;
  late TextEditingController _typeController;
  late TextEditingController _companyUrlController;
  late TextEditingController _descriptionController;
  late TextEditingController _techController;
  late TextEditingController _orderController;

  @override
  void initState() {
    super.initState();
    final e = widget.experience;
    _companyController = TextEditingController(text: e?.company ?? '');
    _positionController = TextEditingController(text: e?.position ?? '');
    _durationController = TextEditingController(text: e?.duration ?? '');
    _locationController = TextEditingController(text: e?.location ?? 'Remote');
    _typeController = TextEditingController(text: e?.type ?? 'Full-time');
    _companyUrlController = TextEditingController(text: e?.companyUrl ?? '');
    _descriptionController = TextEditingController(text: e?.description ?? '');
    _techController =
        TextEditingController(text: e?.technologies.join(', ') ?? '');
    _orderController = TextEditingController(text: (e?.order ?? 0).toString());
  }

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _durationController.dispose();
    _locationController.dispose();
    _typeController.dispose();
    _companyUrlController.dispose();
    _descriptionController.dispose();
    _techController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final techList = _techController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final experience = Experience(
      id: widget.experience?.id,
      company: _companyController.text.trim(),
      position: _positionController.text.trim(),
      duration: _durationController.text.trim(),
      location: _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim(),
      type: _typeController.text.trim().isEmpty
          ? null
          : _typeController.text.trim(),
      companyUrl: _companyUrlController.text.trim(),
      description: _descriptionController.text.trim(),
      technologies: techList,
      order: int.tryParse(_orderController.text.trim()) ?? 0,
    );

    widget.onSave(experience);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 750),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        widget.experience == null
                            ? Icons.add_circle_outline_rounded
                            : Icons.edit_note_rounded,
                        color: AppColors.accent,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.experience == null
                            ? 'Add Experience'
                            : 'Update Experience',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.close, color: AppColors.textSecondary),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const Divider(color: AppColors.glassBorder),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField(
                          controller: _companyController,
                          label: 'Company Name *',
                          validator: (v) =>
                              v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _positionController,
                          label: 'Position / Role *',
                          validator: (v) =>
                              v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _durationController,
                                label: 'Duration (e.g. Jul 2023 - Present) *',
                                validator: (v) => v == null || v.trim().isEmpty
                                    ? 'Required'
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 100,
                              child: _buildTextField(
                                controller: _orderController,
                                label: 'Order',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _locationController,
                                label: 'Location (e.g. Remote, Hybrid)',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildTextField(
                                controller: _typeController,
                                label: 'Job Type (e.g. Full-time)',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _companyUrlController,
                          label: 'Company Website URL',
                          hint: 'https://...',
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _techController,
                          label: 'Technologies (comma-separated)',
                          hint: 'Python, SQL, LangChain, Flutter, Docker',
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _descriptionController,
                          label: 'Description / Bullet Points *',
                          maxLines: 6,
                          hint:
                              '- Drove planning and delivery...\n- Built RAG pipelines...',
                          validator: (v) =>
                              v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel',
                        style: TextStyle(color: AppColors.textSecondary)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: _save,
                    icon: Icon(
                      widget.experience == null
                          ? Icons.add_rounded
                          : Icons.check_circle_outline_rounded,
                      size: 18,
                    ),
                    label: Text(
                      widget.experience == null
                          ? 'Add Experience'
                          : 'Update Experience',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle:
            const TextStyle(color: AppColors.textSecondary, fontSize: 13),
        hintStyle: TextStyle(
            color: AppColors.textSecondary.withValues(alpha: 0.5),
            fontSize: 13),
        filled: true,
        fillColor: AppColors.background.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.accent),
        ),
      ),
    );
  }
}
