import 'package:flutter/material.dart';
import '../widgets/general_input_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/top_navbar.dart'; // ƒo. nuevo navbar
import '../widgets/section_title.dart';

import 'profile_screen.dart';
import 'main_screen.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final repeatpasswordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true, // ƒo. permite que se ajuste con el teclado
      body: SafeArea(
        child: Column(
          children: [
            // ÐYYœ NAVBAR SUPERIOR
            TopNavbar(
              title: "Volver a perfil",
              onBack: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
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

                            SectionTitle(
                              text: "Ingrese la",
                              secondLine: "nueva contraseña a cambiar",
                            ),
                            const SizedBox(height: 24),

                            // Campo de contraseña
                            GeneralInputField(
                              icon: Icons.lock_rounded,
                              hintText: 'Nueva contraseña',
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                            ),

                            // Repetición de contraseña
                            GeneralInputField(
                              icon: Icons.lock_rounded,
                              hintText: 'Repetir nueva contraseña',
                              controller: repeatpasswordController,
                              keyboardType: TextInputType.visiblePassword,
                            ),

                            const SizedBox(height: 24),

                            // Botón principal
                            PrimaryButton(
                              text: "Guardar nueva contraseña",
                              variant: ButtonVariant.secondary,
                              onPressed: () {
                                print("Envía email de recuperación");

                                print("Vuelva a la pantalla principal");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const MainScreen(),
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
          ],
        ),
      ),
    );
  }
}
