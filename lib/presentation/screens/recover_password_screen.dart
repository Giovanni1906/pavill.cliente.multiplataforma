import 'package:aplicativopavillcliente_flutter/presentation/screens/verify_phone_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/general_input_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/link_text.dart';
import '../widgets/top_navbar.dart'; // ƒo. importa tu nuevo navbar

import 'login_screen.dart';
import 'main_screen.dart';
import '../../core/utils/navigation/verify_flow_navigation.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({super.key});

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
              title: "Inicio de sesión",
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
                              hintText: 'Ingrese su correo electrónico registrado',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),

                            const SizedBox(height: 24),

                            // Botón principal
                            PrimaryButton(
                              text: "Recuperar contraseña",
                              onPressed: () {
                                print("Envía email de recuperación");

                                print("Ir a login");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
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
