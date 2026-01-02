import 'package:aplicativopavillcliente_flutter/presentation/screens/verify_phone_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/general_input_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/link_text.dart';
import '../widgets/terms_and_conditions_sheet.dart';
import '../widgets/top_navbar.dart'; // ƒo. importa tu nuevo navbar

import 'login_screen.dart';
import 'main_screen.dart';
import '../../core/utils/navigation/verify_flow_navigation.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final dniController = TextEditingController();

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
                           
                            // Campo de dni
                            GeneralInputField(
                              icon: Icons.badge_rounded,
                              hintText: 'Documento de identidad',
                              controller: dniController,
                              keyboardType: TextInputType.text,
                            ),

                            // Campo de nombre de usuario
                            GeneralInputField(
                              icon: Icons.person_rounded,
                              hintText: 'Nombres y apellidos',
                              controller: nameController,
                              keyboardType: TextInputType.text,
                            ),

                            // Campo de correo electrónico
                            GeneralInputField(
                              icon: Icons.email_rounded,
                              hintText: 'Correo electrónico',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),

                            // Campo de contraseña
                            GeneralInputField(
                              icon: Icons.lock_rounded,
                              hintText: 'Contraseña',
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                            ),
                            

                            // Campo checkeable
                            // Campo checkeable
                            ListTile(
                              leading: Checkbox(
                                value: _acceptTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _acceptTerms = value ?? false;
                                  });
                                },
                              ),
                              title: GestureDetector(
                                onTap: () => TermsAndConditionsSheet.show(context),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.color ??
                                          Colors.black,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text:
                                            'Al crear su cuenta, usted declara haber aceptado los ',
                                      ),
                                      TextSpan(
                                        text: 'términos y condiciones',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(text: '.'),
                                    ],
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),

                            const SizedBox(height: 24),

                            // Botón principal
                            PrimaryButton(
                              text: "Crear cuenta",
                              onPressed: () {
                                print("Bien registrado");
                                print("Envía email de recuperación");
                                print("Ir a map");

                                print("Mal registrado");
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
                text: "Ya tienes una cuenta? Inicia sesión",
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
