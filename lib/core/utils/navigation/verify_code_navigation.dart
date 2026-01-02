import 'package:aplicativopavillcliente_flutter/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../../presentation/screens/main_screen.dart';
import '../../../presentation/screens/new_password_screen.dart';
import '../../../presentation/screens/register_screen.dart';

import 'verify_flow_navigation.dart';

void handleVerifyCodeNavigation({
  required BuildContext context,
  required VerifyOrigin origin,
  required VerifyAction action,
}) {
  if (origin == VerifyOrigin.main || origin == VerifyOrigin.login) {
    // Si la acción es crear cuenta, navega a RegisterScreen
    if (action == VerifyAction.createAccount) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegisterScreen()),
      );
      return;
    }
  }

  if (origin == VerifyOrigin.profile) {
    // Si la acción es cambiar contraseña, navega a NewPasswordScreen
    if (action == VerifyAction.changePassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
      );
      return;
    }
    // Si la acción es cambiar teléfono, navega a ProfileScreen
    if (action == VerifyAction.changePhone) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
      return;
    }
    // Por defecto, navega a MainScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
    );
    return;
  }

  // Por defecto, navega a MainScreen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const MainScreen()),
  );
  return;
}