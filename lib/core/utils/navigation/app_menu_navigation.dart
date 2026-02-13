import 'package:flutter/material.dart';

import '../../../presentation/screens/main_screen.dart';
import '../../../presentation/screens/map_screen.dart';
import '../../../presentation/screens/profile_screen.dart';
import '../../../presentation/widgets/app_menu_drawer.dart';
import '../../services/session_storage.dart';

Future<void> handleAppMenuTap({
  required BuildContext context,
  required AppMenuItem item,
  AppMenuItem? currentItem,
}) async {
  Navigator.of(context).pop();

  if (currentItem == item) {
    return;
  }

  switch (item) {
    case AppMenuItem.home:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const MapScreen(),
        ),
      );
      break;
    case AppMenuItem.editProfile:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
      );
      break;
    case AppMenuItem.favoriteAddresses:
      break;
    case AppMenuItem.logout:
      await SessionStorage().clear();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const MainScreen(),
        ),
        (route) => false,
      );
      break;
  }
}
