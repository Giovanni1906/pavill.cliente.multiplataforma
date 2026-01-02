import 'package:aplicativopavillcliente_flutter/presentation/screens/verify_phone_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/general_input_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/link_text.dart';
import '../widgets/app_menu_drawer.dart';
import '../widgets/top_navbar.dart';

import 'login_screen.dart';
import 'map_screen.dart';
import 'main_screen.dart';
import '../../core/utils/navigation/verify_flow_navigation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final dniController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: AppMenuDrawer(
        currentItem: AppMenuItem.editProfile,
        onItemTap: (item) {
          Navigator.of(context).pop();
          switch (item) {
            case AppMenuItem.home:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const MapScreen(),
                ),
              );
              break;
            case AppMenuItem.editProfile:
              break;
            case AppMenuItem.favoriteAddresses:
              break;
            case AppMenuItem.logout:
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(),
                ),
                (route) => false,
              );
              break;
          }
        },
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


                            const SizedBox(height: 24),
                            // Boton principal
                            PrimaryButton(
                              text: "Guardar cambios",
                              onPressed: () {
                                print("Cambios guardados");

                              },
                            ),
                            PrimaryButton(
                              text: "Eliminar cuenta",
                              variant: ButtonVariant.secondary,
                              onPressed: () {
                                print("Cuenta eliminada");
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => const MainScreen(),
                                  ),
                                  (route) => false,
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
    );
  }
}
