import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/services/location_permission_helper.dart';
import '../../core/theme/app_theme_colors.dart';
import '../widgets/app_bottom_sheet.dart';
import '../widgets/circular_icon_button.dart';
import '../widgets/contact_action_button.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/cancel_reason_dialog.dart';
import '../widgets/driver_message_dialog.dart';
import '../widgets/primary_button.dart';
import '../widgets/rating_stars.dart';
import '../widgets/section_title.dart';
import 'progress_screen.dart';
import 'map_screen.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  bool _locationReady = false;
  bool _mapLoading = true;
  bool _loadingDialogVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestLocation();
      _showLoadingDialog();
    });
  }

  void _showLoadingDialog() {
    if (_loadingDialogVisible || !mounted) return;
    _loadingDialogVisible = true;
    LoadingDialog.show(context, message: 'Cargando mapa...');
  }

  void _hideLoadingDialog() {
    if (!_loadingDialogVisible || !mounted) return;
    _loadingDialogVisible = false;
    LoadingDialog.hide(context);
  }

  Future<void> _requestLocation() async {
    final allowed = await LocationPermissionHelper.ensureLocationEnabled(context);
    if (mounted) {
      setState(() {
        _locationReady = allowed;
      });
    }
  }

  Future<void> _goToCurrentLocation() async {
    final allowed = await LocationPermissionHelper.ensureLocationEnabled(context);
    if (!allowed) return;

    if (!_mapController.isCompleted) return;
    final controller = await _mapController.future;

    final lastPosition = await Geolocator.getLastKnownPosition();
    if (lastPosition != null) {
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lastPosition.latitude, lastPosition.longitude),
            zoom: 16,
          ),
        ),
      );
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        timeLimit: const Duration(seconds: 5),
      );
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 16,
          ),
        ),
      );
    } catch (_) {}
  }

  @override
  void dispose() {
    if (_loadingDialogVisible) {
      LoadingDialog.hide(context);
      _loadingDialogVisible = false;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(-12.0464, -77.0428),
              zoom: 14,
            ),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            myLocationEnabled: _locationReady,
            onMapCreated: (controller) {
              if (!_mapController.isCompleted) {
                _mapController.complete(controller);
              }
            },
            onCameraIdle: () {
              if (_mapLoading) {
                Future.delayed(const Duration(milliseconds: 700), () {
                  if (!mounted) return;
                  setState(() {
                    _mapLoading = false;
                  });
                  _hideLoadingDialog();
                });
              }
            },
          ),
          Positioned(
            top: 12,
            right: 12,
            child: SafeArea(
              child: CircularIconButton(
                icon: Icons.my_location,
                onTap: _goToCurrentLocation,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                iconColor: Colors.white,
              ),
            ),
          ),
          AppBottomSheet(
            initialChildSize: 0.57,
            minChildSize: 0.07,
            maxChildSize: 0.6,
            autoSize: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SectionTitle(
                  text: "Tu pavill esta en camino",
                  secondLine: "Buscando ubicacion del conductor...",
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ContactActionButton(
                      icon: Icons.message,
                      onTap: () {
                        DriverMessageDialog.show(
                          context,
                          title:
                              "Seleccione una opcion para enviar un mensaje al conductor",
                          options: const [
                            "Saldre ahora",
                            "Estoy afuera",
                            "Espereme 1 min",
                          ],
                          actionText: "Enviar",
                          onSubmit: (option) {
                            print("Mensaje al conductor: $option");
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: colors.box,
                      backgroundImage:
                          const AssetImage('assets/images/taxista.png'),
                    ),
                    const SizedBox(width: 16),
                    ContactActionButton(
                      icon: Icons.call,
                      onTap: () {
                        print("Llamar al conductor");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const RatingStars(rating: 4),
                const SizedBox(height: 6),
                Text(
                  "Conductor de Pavill",
                  style: TextStyle(
                    color: colors.text,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "No registrado",
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Modelo: No registrado | Placa: No registrado",
                  style: TextStyle(
                    color: colors.text,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: "Cancelar",
                  variant: ButtonVariant.secondary,
                  onPressed: () {
                    CancelReasonDialog.show(
                      context,
                      title: "Seleccione el motivo de su cancelación",
                      imageAsset: "assets/images/route.png",
                      reasons: const [
                        "Problemas con el conductor",
                        "Demora excesiva",
                        "Otros motivos",
                      ],
                      commentHint: "Comentario adicional",
                      actionText: "Listo",
                      onSubmit: (reasons, comment) {
                        print("Cancelar pedido: $reasons | $comment");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MapScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),
                PrimaryButton(
                  text: "A bordo",
                  variant: ButtonVariant.primary,
                  onPressed: () {
                    print("Pasajero a bordo");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const ProgressScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
