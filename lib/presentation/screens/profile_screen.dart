import 'package:aplicativopavillcliente_flutter/presentation/screens/verify_phone_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/general_input_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/link_text.dart';
import '../widgets/app_menu_drawer.dart';
import '../widgets/top_navbar.dart';

import 'main_screen.dart';
import '../../core/utils/navigation/app_menu_navigation.dart';
import '../../core/utils/navigation/verify_flow_navigation.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final dniController = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel()..loadSession(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        drawer: AppMenuDrawer(
          currentItem: AppMenuItem.editProfile,
          onItemTap: (item) => handleAppMenuTap(
            context: context,
            item: item,
            currentItem: AppMenuItem.editProfile,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Navbar superior
              Builder(
                builder: (context) {
                  return TopNavbar(
                    title: "Menu principal",
                    leadingIcon: Icons.menu,
                    onBack: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),

              // Contenido principal
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Consumer<ProfileViewModel>(
                            builder: (context, viewModel, _) {
                              final session = viewModel.session;
                              if (session != null) {
                                if (dniController.text.isEmpty &&
                                    session.numeroDocumento != null) {
                                  dniController.text =
                                      session.numeroDocumento ?? '';
                                }
                                if (nameController.text.isEmpty &&
                                    session.nombre != null) {
                                  nameController.text = session.nombre ?? '';
                                }
                                if (emailController.text.isEmpty &&
                                    session.email != null) {
                                  emailController.text = session.email ?? '';
                                }
                              }

                              return Column(
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
                                    hintText: 'Nombre de usuario',
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

                                  if (viewModel.successMessage != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Text(
                                        viewModel.successMessage!,
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 13,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                  const SizedBox(height: 24),
                                  // Boton principal
                                  PrimaryButton(
                                    text: "Guardar cambios",
                                    onPressed: viewModel.isLoading
                                        ? () {}
                                        : () {
                                            viewModel.actualizarPerfil(
                                              numeroDocumento:
                                                  dniController.text.trim(),
                                              nombre: nameController.text.trim(),
                                              email: emailController.text.trim(),
                                            );
                                          },
                                  ),
                                  PrimaryButton(
                                    text: "Eliminar cuenta",
                                    variant: ButtonVariant.secondary,
                                    onPressed: () {
                                      print("Cuenta eliminada");
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (_) => MainScreen(),
                                        ),
                                        (route) => false,
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

              // Footer
              Padding(
                padding: const EdgeInsets.only(bottom: 2, top: 8),
                child: LinkText(
                  text: "Cambiar contraseña",
                  onTap: () {
                    print("Ir a verifyphone");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const VerifyPhoneScreen(
                          origin: VerifyOrigin.profile,
                          action: VerifyAction.changePassword,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 2),
                child: LinkText(
                  text: "Cambiar número de teléfono",
                  onTap: () {
                    print("Ir a verifyphone");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const VerifyPhoneScreen(
                          origin: VerifyOrigin.profile,
                          action: VerifyAction.changePhone,
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
