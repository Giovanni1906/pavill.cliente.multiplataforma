import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/services/location_permission_helper.dart';
import '../widgets/app_bottom_sheet.dart';
import '../widgets/circular_icon_button.dart';
import '../widgets/general_input_field.dart';
import '../widgets/app_menu_drawer.dart';
import '../widgets/back_exit_handler.dart';
import '../widgets/location_input_sheet.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/primary_button.dart';
import '../widgets/section_title.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'confirm_screen.dart';

class MapScreen extends StatefulWidget {
  final IconData actionIcon;
  final VoidCallback? onActionTap;

  const MapScreen({
    super.key,
    this.actionIcon = Icons.menu,
    this.onActionTap,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final Completer<GoogleMapController> _mapController = Completer();
  bool _locationReady = false;
  bool _mapLoading = true;
  bool _loadingDialogVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  void _openLocationSheet({required bool isOrigin}) {
    final title = isOrigin ? 'Direccion de origen' : 'Direccion de destino';
    final hint = isOrigin ? 'Lugar de origen' : 'Lugar de destino';
    final controller = isOrigin ? _originController : _destinationController;

    LocationInputSheet.show(
      context,
      title: title,
      hintText: hint,
      controller: controller,
      onSelectMap: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    if (_loadingDialogVisible) {
      LoadingDialog.hide(context);
      _loadingDialogVisible = false;
    }
    _originController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackExitHandler(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppMenuDrawer(
          currentItem: AppMenuItem.home,
          onItemTap: (item) {
            Navigator.of(context).pop();
            switch (item) {
              case AppMenuItem.home:
                break;
              case AppMenuItem.editProfile:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                );
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
              left: 12,
              child: SafeArea(
                child: CircularIconButton(
                  icon: widget.actionIcon,
                  onTap: widget.onActionTap ??
                      () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                ),
              ),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SectionTitle(text: "Hola, ¿A dónde vamos?"),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => _openLocationSheet(isOrigin: true),
                    child: AbsorbPointer(
                      child: GeneralInputField(
                        icon: Icons.my_location,
                        hintText: 'Origen',
                        controller: _originController,
                        keyboardType: TextInputType.text,
                        trailingIcon: Icons.delete_outline,
                        onTrailingTap: _originController.clear,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _openLocationSheet(isOrigin: false),
                    child: AbsorbPointer(
                      child: GeneralInputField(
                        icon: Icons.location_on_outlined,
                        hintText: 'Destino',
                        controller: _destinationController,
                        keyboardType: TextInputType.text,
                        trailingIcon: Icons.delete_outline,
                        onTrailingTap: _destinationController.clear,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  PrimaryButton(
                    text: "Continuar",
                    onPressed: () {
                      print("Ir a confirm");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ConfirmScreen(),
                        ),
                      );
                    },
                    variant: ButtonVariant.secondary,

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
