import 'package:flutter/material.dart';

import '../../core/theme/app_theme_colors.dart';

class CheckboxField extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CheckboxField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => onChanged(!value),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colors.box,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              shape: const CircleBorder(),
              activeColor: colors.primary,
              side: BorderSide(color: colors.primary, width: 1.4),
            ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
