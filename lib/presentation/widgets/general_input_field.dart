import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart'; // themas de colores
import '../../core/theme/app_colors.dart';       // colores fijos

class GeneralInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;


  const GeneralInputField({
    super.key,
    required this.icon,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.trailingIcon,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colors.box, // fondo gris suave
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          // Ícono circular con sombra
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: colors.glow,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),

          // Campo de texto
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: TextStyle(
                fontSize: 14,
                color: colors.text,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: colors.text,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (trailingIcon != null)
            InkResponse(
              onTap: onTrailingTap,
              radius: 14,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Icon(trailingIcon, size: 18, color: colors.text),
              ),
            ),
        ],
      ),
    );
  }
}
