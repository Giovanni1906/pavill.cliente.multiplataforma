import 'package:flutter/material.dart';

import '../../core/theme/app_theme_colors.dart';
import 'checkbox_field.dart';
import 'primary_button.dart';
import 'section_title.dart';

class DriverMessageDialog extends StatefulWidget {
  final String title;
  final List<String> options;
  final String actionText;
  final void Function(String? option) onSubmit;

  const DriverMessageDialog({
    super.key,
    required this.title,
    required this.options,
    required this.actionText,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required List<String> options,
    required String actionText,
    required void Function(String? option) onSubmit,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: DriverMessageDialog(
            title: title,
            options: options,
            actionText: actionText,
            onSubmit: onSubmit,
          ),
        );
      },
    );
  }

  @override
  State<DriverMessageDialog> createState() => _DriverMessageDialogState();
}

class _DriverMessageDialogState extends State<DriverMessageDialog> {
  int? _selectedIndex;

  void _toggleOption(int index, bool? value) {
    setState(() {
      if (value == true) {
        _selectedIndex = index;
      } else if (_selectedIndex == index) {
        _selectedIndex = null;
      }
    });
  }

  void _submit() {
    final selected =
        _selectedIndex == null ? null : widget.options[_selectedIndex!];
    Navigator.of(context).pop();
    widget.onSubmit(selected);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;
    final maxHeight = MediaQuery.of(context).size.height * 0.68;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              const SizedBox(height: 4),
              SectionTitle(text: widget.title),
              const SizedBox(height: 12),
              Column(
                children: List.generate(
                  widget.options.length,
                  (index) => CheckboxField(
                    label: widget.options[index],
                    value: _selectedIndex == index,
                    onChanged: (value) => _toggleOption(index, value),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                text: widget.actionText,
                variant: ButtonVariant.secondary,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
