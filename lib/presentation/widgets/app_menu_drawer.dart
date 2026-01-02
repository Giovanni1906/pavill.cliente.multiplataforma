import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';

enum AppMenuItem {
  home,
  editProfile,
  favoriteAddresses,
  logout,
}

class AppMenuDrawer extends StatelessWidget {
  final AppMenuItem currentItem;
  final ValueChanged<AppMenuItem> onItemTap;

  const AppMenuDrawer({
    super.key,
    required this.currentItem,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppThemeColors>()!;
    final onPrimary = theme.colorScheme.onPrimary;

    Widget buildItem(AppMenuItem item, String label) {
      final selected = currentItem == item;
      return ListTile(
        title: Text(label),
        selected: selected,
        textColor: colors.text,
        selectedColor: colors.text.withOpacity(0.7),
        selectedTileColor: colors.slowPrimary.withOpacity(0.15),
        onTap: () => onItemTap(item),
      );
    }

    return Drawer(
      backgroundColor: colors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: colors.primary),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundImage: const AssetImage('assets/images/perfil.webp'),
                  backgroundColor: onPrimary.withOpacity(0.2),
                ),
                const SizedBox(height: 12),
                Text(
                  'CLIENTE',
                  style: TextStyle(
                    color: onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'usuario@correo.com',
                  style: TextStyle(color: onPrimary.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          buildItem(AppMenuItem.home, 'Inicio'),
          buildItem(AppMenuItem.editProfile, 'Editar perfil'),
          buildItem(AppMenuItem.favoriteAddresses, 'Direcciones favoritas'),
          buildItem(AppMenuItem.logout, 'Cerrar sesion'),
        ],
      ),
    );
  }
}
