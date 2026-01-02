import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionHelper {
  static Future<bool> ensureLocationEnabled(BuildContext context) async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final openSettings = await _showDialog(
        context,
        title: 'Ubicacion desactivada',
        message: 'Activa la ubicacion para continuar.',
        confirmText: 'Activar',
      );
      if (openSettings == true) {
        await Geolocator.openLocationSettings();
      }
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      return false;
    }

    if (permission == LocationPermission.deniedForever) {
      final openSettings = await _showDialog(
        context,
        title: 'Permiso denegado',
        message:
            'Debes habilitar el permiso de ubicacion desde los ajustes.',
        confirmText: 'Abrir ajustes',
      );
      if (openSettings == true) {
        await Geolocator.openAppSettings();
      }
      return false;
    }

    return true;
  }

  static Future<bool?> _showDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }
}
