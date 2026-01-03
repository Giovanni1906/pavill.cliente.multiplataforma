import 'package:flutter/material.dart';
import '../widgets/multiline_input_field.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_colors.dart';
import '../widgets/primary_button.dart';
import '../widgets/top_navbar.dart'; // nuevo navbar

import 'map_screen.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationController = TextEditingController();
    final colors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      resizeToAvoidBottomInset: true, // permite que se ajuste con el teclado
      body: SafeArea(
        child: Column(
          children: [
            // NAVBAR SUPERIOR
            TopNavbar(
              title: "Volver al mapa",
              onBack: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const MapScreen(),
                  ),
                );
              },
            ),

            // CONTENIDO PRINCIPAL
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

                            Image.asset(
                              'assets/images/taxi_cost.png',
                              width: 160,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tarifa aproximada',
                              style: TextStyle(
                                color: colors.text,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'S/ XX.XX',
                              style: TextStyle(
                                color: colors.primary,
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _LocationRow(
                              icon: Icons.circle,
                              iconColor: colors.primary,
                              label: 'Origen:',
                              value: 'Error (volver a marcar)',
                            ),
                            const SizedBox(height: 8),
                            _LocationRow(
                              icon: Icons.place,
                              iconColor: AppColors.secondary,
                              label: 'Destino:',
                              value: 'Error (volver a marcar)',
                            ),
                            const SizedBox(height: 24),

                            // campo de direccion
                            MultiLineInputField(
                              icon: Icons.location_city,
                              hintText: 'Direccion exacta',
                              controller: LocationController,
                              trailingIcon: Icons.delete_outline,
                              onTrailingTap: () {
                                LocationController.clear();
                              },
                              trailingIconSecondary: Icons.favorite_border,
                              onTrailingSecondaryTap: () {
                                print('Agregar a favoritos');
                              },
                            ),

                            const SizedBox(height: 24),

                            // Boton principal
                            PrimaryButton(
                              text: "Pedir un Pavill",
                              variant: ButtonVariant.secondary,
                              onPressed: () {
                                print("Pide un pavill");

                                print("Ir a searing screen");

                              },
                            ),

                            // Boton principal
                            PrimaryButton(
                              text: "Cancelar",
                              variant: ButtonVariant.primary,
                              onPressed: () {
                                print("Cancela pedido");

                                print("Ir a map");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const MapScreen(),
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

class _LocationRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _LocationRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: colors.text,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  color: colors.text,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
