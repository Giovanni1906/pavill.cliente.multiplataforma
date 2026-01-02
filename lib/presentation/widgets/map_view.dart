import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final CameraPosition initialCameraPosition;
  final bool myLocationEnabled;
  final bool showLoadingOverlay;
  final ValueChanged<GoogleMapController>? onMapCreated;
  final int loadingDelayMs;

  const MapView({
    super.key,
    required this.initialCameraPosition,
    this.myLocationEnabled = false,
    this.showLoadingOverlay = true,
    this.onMapCreated,
    this.loadingDelayMs = 700,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  bool _mapLoading = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: widget.initialCameraPosition,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: widget.myLocationEnabled,
          onMapCreated: (controller) {
            if (widget.onMapCreated != null) {
              widget.onMapCreated!(controller);
            }
          },
          onCameraIdle: () {
            if (!widget.showLoadingOverlay) return;
            if (_mapLoading) {
              Future.delayed(Duration(milliseconds: widget.loadingDelayMs), () {
                if (!mounted) return;
                setState(() {
                  _mapLoading = false;
                });
              });
            }
          },
        ),
        if (widget.showLoadingOverlay && _mapLoading)
          Container(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/animations/loading.gif',
                    width: 64,
                    height: 64,
                  ),
                  const SizedBox(height: 8),
                  const Text('Cargando mapa...'),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
