import 'package:flutter/material.dart';
import '../widgets/general_input_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/link_text.dart';
import '../widgets/top_navbar.dart'; // ƒo. importa tu nuevo navbar
import '../widgets/loading_dialog.dart';

import 'verify_phone_screen.dart';
import 'recover_password_screen.dart';
import 'main_screen.dart';
import 'map_screen.dart';
import '../../core/utils/navigation/verify_flow_navigation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true, // ƒo. permite que se ajuste con el teclado
      body: SafeArea(
        child: Column(
          children: [
            // ÐYYœ NAVBAR SUPERIOR
            TopNavbar(
              title: "Volver al inicio",
              onBack: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const MainScreen(),
                  ),
                );
              },
            ),

            // ÐYY¸ CONTENIDO PRINCIPAL
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 48),

                            // Campo de correo electrónico
                            GeneralInputField(
                              icon: Icons.alternate_email_rounded,
                              hintText: 'Correo electrónico',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 12),

                            // Campo de contraseña
                            GeneralInputField(
                              icon: Icons.lock_outline_rounded,
                              hintText: 'Contraseña',
                              controller: passwordController,
                              obscureText: true,
                            ),

                            const SizedBox(height: 24),

                            // Botón principal
                            PrimaryButton(
                              text: "Iniciar sesión",
                              onPressed: () async {
                                LoadingDialog.show(context, message: 'Iniciando sesión...');
                                
                                // Simular operación de login
                                await Future.delayed(const Duration(seconds: 2));
                                
                                if (context.mounted) {
                                  LoadingDialog.hide(context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const MapScreen(),
                                    ),
                                  );
                                }
                              },
                            ),

                            // Texto de recuperar contraseña
                            LinkText(
                              text: "¿Olvidaste tu contraseña?",
                              onTap: () {
                                print("Redirigir a recuperar contraseña");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const RecoverPasswordScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // FOOTER: Texto fijo abajo
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 8),
              child: LinkText(
                text: "¿No tienes una cuenta? Regístrate",
                onTap: () {
                  print("Ir a verifyphone");
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const VerifyPhoneScreen(
                        origin: VerifyOrigin.login,
                        action: VerifyAction.createAccount,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
