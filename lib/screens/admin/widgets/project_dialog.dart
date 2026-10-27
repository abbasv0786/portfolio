import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../../../models/project.dart';
import '../../../services/image_service.dart';
import '../../../widgets/app_image.dart';

class ProjectDialog extends StatefulWidget {
  final Project? project;
  final Function(Project) onSave;

  const ProjectDialog({
    super.key,
    this.project,
    required this.onSave,
  });

  @override
  State<ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;
  late TextEditingController _categoryController;
  late TextEditingController _techController;
  late TextEditingController _liveUrlController;
  late TextEditingController _androidUrlController;
  late TextEditingController _iosUrlController;
  late TextEditingController _orderController;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    final p = widget.project;
    _titleController = TextEditingController(text: p?.title ?? '');
    _descriptionController = TextEditingController(text: p?.description ?? '');
    _imageUrlController = TextEditingController(text: p?.imageUrl ?? '');
    _categoryController = TextEditingController(text: p?.category ?? 'Flutter');
    _techController =
        TextEditingController(text: p?.technologies.join(', ') ?? '');
    _liveUrlController = TextEditingController(text: p?.liveUrl ?? '');
    _androidUrlController = TextEditingController(text: p?.androidUrl ?? '');
    _iosUrlController = TextEditingController(text: p?.iOSUrl ?? '');
    _orderController = TextEditingController(text: (p?.order ?? 0).toString());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _categoryController.dispose();
    _techController.dispose();
    _liveUrlController.dispose();
    _androidUrlController.dispose();
    _iosUrlController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    setState(() => _isUploading = true);
    try {
      final dataUrl = await ImageService.pickImageAsDataUrl();
      if (dataUrl != null) setState(() => _imageUrlController.text = dataUrl);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Image upload failed: ${e.toString().replaceFirst('Exception: ', '')}'),
              backgroundColor: Colors.red.shade800),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    if (_isUploading) return;

    final techList = _techController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final project = Project(
      id: widget.project?.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: _imageUrlController.text.trim(),
      category: _categoryController.text.trim().isEmpty
          ? null
          : _categoryController.text.trim(),
      technologies: techList,
      liveUrl: _liveUrlController.text.trim().isEmpty
          ? null
          : _liveUrlController.text.trim(),
      androidUrl: _androidUrlController.text.trim().isEmpty
          ? null
          : _androidUrlController.text.trim(),
      iOSUrl: _iosUrlController.text.trim().isEmpty
          ? null
          : _iosUrlController.text.trim(),
      order: int.tryParse(_orderController.text.trim()) ?? 0,
    );

    widget.onSave(project);
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
                        widget.project == null
                            ? Icons.add_circle_outline_rounded
                            : Icons.edit_note_rounded,
                        color: AppColors.accent,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.project == null
                            ? 'Add New Project'
                            : 'Update Project',
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
                          controller: _titleController,
                          label: 'Project Title *',
                          validator: (v) =>
                              v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _categoryController,
                                label: 'Category (e.g., Flutter, AI/ML, iOS)',
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
                        _buildTextField(
                          controller: _descriptionController,
                          label: 'Description *',
                          maxLines: 4,
                          validator: (v) =>
                              v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildTextField(
                                controller: _imageUrlController,
                                label: 'Image',
                                hint: 'Upload an image, or paste https://...',
                                readOnly: ImageService.isDataUrl(
                                    _imageUrlController.text),
                                onChanged: (_) => setState(() {}),
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              height: 48,
                              child: OutlinedButton.icon(
                                onPressed:
                                    _isUploading ? null : _pickAndUploadImage,
                                icon: _isUploading
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: AppColors.accent),
                                      )
                                    : const Icon(Icons.cloud_upload_outlined,
                                        size: 18),
                                label: Text(
                                    _isUploading ? 'Uploading...' : 'Upload'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.accent,
                                  side:
                                      const BorderSide(color: AppColors.accent),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_imageUrlController.text.trim().isNotEmpty) ...[
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: AppImage(
                              _imageUrlController.text.trim(),
                              height: 140,
                              width: double.infinity,
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _techController,
                          label: 'Technologies (comma-separated) *',
                          hint: 'Flutter, Dart, Firebase, Python',
                          validator: (v) =>
                              v == null || v.trim().isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _liveUrlController,
                          label: 'Live Demo URL',
                          hint: 'https://...',
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _androidUrlController,
                          label: 'Android Play Store URL',
                          hint: 'https://play.google.com/...',
                        ),
                        const SizedBox(height: 12),
                        _buildTextField(
                          controller: _iosUrlController,
                          label: 'iOS App Store URL',
                          hint: 'https://apps.apple.com/...',
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
                    onPressed: _isUploading ? null : _save,
                    icon: Icon(
                      widget.project == null
                          ? Icons.add_rounded
                          : Icons.check_circle_outline_rounded,
                      size: 18,
                    ),
                    label: Text(
                      widget.project == null ? 'Add Project' : 'Update Project',
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
    ValueChanged<String>? onChanged,
    bool readOnly = false,
  }) {
    if (readOnly) {
      // Don't render a huge base64 string in a text field
      return InputDecorator(
        decoration: _decoration(label, hint),
        child: Row(
          children: [
            const Expanded(
              child: Text('Uploaded image (stored in Firestore)',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
            ),
            InkWell(
              onTap: () => setState(() => controller.clear()),
              child: const Icon(Icons.close,
                  size: 18, color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 14),
      decoration: _decoration(label, hint),
    );
  }

  InputDecoration _decoration(String label, String? hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
      hintStyle: TextStyle(
          color: AppColors.textSecondary.withValues(alpha: 0.5), fontSize: 13),
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
    );
  }
}
