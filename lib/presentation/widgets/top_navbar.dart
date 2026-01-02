import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';
import 'circular_icon_button.dart';

class TopNavbar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final IconData? leadingIcon;

  const TopNavbar({
    super.key,
    required this.title,
    required this.onBack,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      color: colors.primary, // 🎨 fondo del navbar
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 Botón circular tipo CardView
          CircularIconButton(
            icon: leadingIcon ?? Icons.arrow_back_rounded,
            onTap: onBack,
            backgroundColor: colors.primary,
            iconColor: Colors.white,
          ),

          const SizedBox(width: 16),

          // 🔸 Texto del navbar
          Text(
            title,
            style: const TextStyle(
              color: Colors.white, // quantum_white_100
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
