import 'package:flutter/material.dart';
import '../../presentation/widgets/app_menu_drawer.dart';

class AppMenuItemData {
  final AppMenuItem item;
  final String label;
  final IconData icon;

  const AppMenuItemData({
    required this.item,
    required this.label,
    required this.icon,
  });
}

class AppMenuItems {
  static const List<AppMenuItemData> all = [
    AppMenuItemData(
      item: AppMenuItem.home,
      label: 'Inicio',
      icon: Icons.home_rounded,
    ),
    AppMenuItemData(
      item: AppMenuItem.editProfile,
      label: 'Editar perfil',
      icon: Icons.person_rounded,
    ),
    AppMenuItemData(
      item: AppMenuItem.favoriteAddresses,
      label: 'Direcciones favoritas',
      icon: Icons.favorite_rounded,
    ),
    AppMenuItemData(
      item: AppMenuItem.logout,
      label: 'Cerrar sesión',
      icon: Icons.logout_rounded,
    ),
  ];
}
