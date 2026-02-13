import 'package:flutter/material.dart';
import '../../core/constants/app_menu_items.dart';
import '../../core/theme/app_theme_colors.dart';
import '../../core/services/session_storage.dart';

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

    Widget buildItem(AppMenuItem item, String label, IconData icon) {
      final selected = currentItem == item;
      final iconColor =
          selected ? colors.primary : colors.text.withOpacity(0.85);
      final textColor =
          selected ? colors.primary : colors.text.withOpacity(0.9);
      return Container(
        color: selected ? colors.primary.withOpacity(0.12) : Colors.transparent,
        child: ListTile(
          leading: Icon(
            icon,
            color: iconColor,
          ),
          title: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          onTap: () => onItemTap(item),
        ),
      );
    }

    return Drawer(
      backgroundColor: colors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder(
            future: SessionStorage().getClienteSession(),
            builder: (context, snapshot) {
              final session = snapshot.data;
              final nombre = session?.nombre?.isNotEmpty == true
                  ? session?.nombre
                  : 'CLIENTE';
              final email = session?.email?.isNotEmpty == true
                  ? session?.email
                  : 'usuario@correo.com';

              return DrawerHeader(
                decoration: BoxDecoration(color: colors.primary),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage:
                          const AssetImage('assets/images/perfil.webp'),
                      backgroundColor: onPrimary.withOpacity(0.2),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      nombre ?? 'CLIENTE',
                      style: TextStyle(
                        color: onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email ?? 'usuario@correo.com',
                      style: TextStyle(color: onPrimary.withOpacity(0.7)),
                    ),
                  ],
                ),
              );
            },
          ),
          for (final item in AppMenuItems.all)
            buildItem(item.item, item.label, item.icon),
        ],
      ),
    );
  }
}
