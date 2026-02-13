import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import '../viewmodels/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _handleLogin(
    BuildContext context,
    LoginViewModel viewModel,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // ignore: avoid_print
    debugPrint("[login] submit email=$email");

    LoadingDialog.show(
      context,
      message: 'Iniciando sesión...',
    );

    await viewModel.login(
      email,
      password,
    );

    if (!context.mounted) return;

    LoadingDialog.hide(context);

    if (viewModel.errorMessage == null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const MapScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Scaffold(
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
                          child: Consumer<LoginViewModel>(
                            builder: (context, viewModel, _) {
                              return Column(
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
                                    onPressed: viewModel.isLoading
                                        ? () {}
                                        : () {
                                            _handleLogin(
                                              context,
                                              viewModel,
                                              emailController,
                                              passwordController,
                                            );
                                          },
                                  ),

                                  if (viewModel.errorMessage != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Text(
                                        viewModel.errorMessage!,
                                        style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 13,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                  const SizedBox(height: 12),

                                  // Texto de recuperar contraseña
                                  LinkText(
                                    text: "¿Olvidaste tu contraseña?",
                                    onTap: () {
                                      print("Redirigir a recuperar contraseña");
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const RecoverPasswordScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
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
      ),
    );
  }
}
