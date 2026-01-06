import 'package:flutter/material.dart';

import '../../core/theme/app_theme_colors.dart';
import 'checkbox_field.dart';
import 'multiline_input_field.dart';
import 'primary_button.dart';
import 'section_title.dart';

// Modal reusable para capturar motivos de cancelacion y comentario adicional.
class CancelReasonDialog extends StatefulWidget {
  final String title;
  final String imageAsset;
  final List<String> reasons;
  final String commentHint;
  final String actionText;
  final void Function(List<String> reasons, String comment) onSubmit;

  const CancelReasonDialog({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.reasons,
    required this.commentHint,
    required this.actionText,
    required this.onSubmit,
  });

  // Helper para abrir el modal sin repetir el Dialog wiring.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String imageAsset,
    required List<String> reasons,
    required String commentHint,
    required String actionText,
    required void Function(List<String> reasons, String comment) onSubmit,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: CancelReasonDialog(
            title: title,
            imageAsset: imageAsset,
            reasons: reasons,
            commentHint: commentHint,
            actionText: actionText,
            onSubmit: onSubmit,
          ),
        );
      },
    );
  }

  @override
  State<CancelReasonDialog> createState() => _CancelReasonDialogState();
}

class _CancelReasonDialogState extends State<CancelReasonDialog> {
  final TextEditingController _commentController = TextEditingController();
  final Set<int> _selectedReasons = <int>{};

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleReason(int index, bool? value) {
    setState(() {
      if (value == true) {
        _selectedReasons.add(index);
      } else {
        _selectedReasons.remove(index);
      }
    });
  }

  void _submit() {
    final selectedLabels = _selectedReasons
        .map((index) => widget.reasons[index])
        .toList();
    Navigator.of(context).pop();
    widget.onSubmit(selectedLabels, _commentController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;
    final maxHeight = MediaQuery.of(context).size.height * 0.78;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cierre rapido del modal.
              Align(
                alignment: Alignment.topRight,
                child: InkResponse(
                  onTap: () => Navigator.of(context).pop(),
                  radius: 18,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: colors.text.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              SectionTitle(text: widget.title),
              const SizedBox(height: 12),
              // Lista de motivos con checkbox.
              Column(
                children: List.generate(
                  widget.reasons.length,
                  (index) => CheckboxField(
                    label: widget.reasons[index],
                    value: _selectedReasons.contains(index),
                    onChanged: (value) => _toggleReason(index, value),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Comentario adicional.
              MultiLineInputField(
                icon: Icons.mode_edit_outline,
                hintText: widget.commentHint,
                controller: _commentController,
                minLines: 1,
                maxLines: 5,
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                text: widget.actionText,
                variant: ButtonVariant.secondary,
                onPressed: _submit,
              ),
              const SizedBox(height: 4),
              Text(
                "Puedes seleccionar mas de un motivo.",
                style: TextStyle(
                  color: colors.text.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
