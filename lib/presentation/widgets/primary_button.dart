import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';

enum ButtonVariant {
  primary,
  secondary,
  alternative,
  success,
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final ButtonVariant variant;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.variant = ButtonVariant.primary, // default
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;

    // 🎨 Configuración según variante
    late final Color backgroundColor;
    late final Color borderColor;
    late final Color textColor;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = colors.primary;
        borderColor = Colors.transparent;
        textColor = Colors.white;
        break;

      case ButtonVariant.secondary:
        backgroundColor = colors.secondary;
        borderColor = Colors.transparent;
        textColor = Colors.white;
        break;

      case ButtonVariant.alternative:
        backgroundColor = Colors.transparent;
        borderColor = colors.primary; // 👈 borde morado
        textColor = Colors.white;
        break;

      case ButtonVariant.success:
        backgroundColor = colors.green;
        borderColor = Colors.transparent;
        textColor = Colors.white;
        break;
    }

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
          boxShadow: variant == ButtonVariant.alternative
              ? null // ❌ sin sombra en outline
              : [
                  BoxShadow(
                    color: backgroundColor.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
