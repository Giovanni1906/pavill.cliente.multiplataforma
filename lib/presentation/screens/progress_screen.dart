import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/services/location_permission_helper.dart';
import '../../core/theme/app_theme_colors.dart';
import '../widgets/app_bottom_sheet.dart';
import '../widgets/circular_icon_button.dart';
import '../widgets/contact_action_button.dart';
import '../widgets/map_view.dart';
import '../widgets/primary_button.dart';
import '../widgets/rating_stars.dart';
import '../widgets/section_title.dart';
import '../widgets/rating_dialog.dart';
import 'map_screen.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  bool _locationReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestLocation();
    });
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
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      body: Stack(
        children: [
          MapView(
            initialCameraPosition: const CameraPosition(
              target: LatLng(-12.0464, -77.0428),
              zoom: 14,
            ),
            myLocationEnabled: _locationReady,
            onMapCreated: (controller) {
              if (!_mapController.isCompleted) {
                _mapController.complete(controller);
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
            initialChildSize: 0.42,
            minChildSize: 0.32,
            maxChildSize: 0.65,
            autoSize: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/route.png",
                  height: 64,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                const SectionTitle(
                  text: "Tu viaje está en progreso",
                ),

                const SizedBox(height: 16),
                PrimaryButton(
                  text: "Finalizar viaje",
                  variant: ButtonVariant.secondary,
                  onPressed: () {
                    RatingDialog.show(
                      context,
                      title: "Califica la experiencia del servicio",
                      imageAsset: "assets/images/taxista.png",
                      subtitle: "Selecciona una puntuacion",
                      reasons: const [
                        "Llego a tiempo",
                        "Demora excesiva",
                        "Otros motivos",
                      ],
                      commentHint: "Dejanos tu comentario.",
                      actionText: "Listo",
                      onSubmit: (rating, reasons, comment) {
                        print(
                          "Rating: $rating | $reasons | $comment",
                        );
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
                  text: "Compartir ubicación",
                  variant: ButtonVariant.success,
                  onPressed: () {
                    print("Compartir ubicación");
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
