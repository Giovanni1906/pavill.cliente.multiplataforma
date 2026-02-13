# Pavill Cliente - Aplicación Multiplataforma

Aplicación móvil Flutter para clientes de Radio Taxi Pavill. Permite solicitar viajes, ver el progreso en tiempo real con mapas, y comunicarse con conductores.

## 📄 Desarrollado por 

Jorge Jefferson Velásquez Valdivia | tech solutions
- contacto: jeff-1906@outlook.com 

## 📋 Características

- 🗺️ **Integración con Google Maps**: Visualización de ubicación y seguimiento de viajes
- 📍 **Geolocalización**: Detección automática de ubicación del cliente
- 🚗 **Seguimiento en tiempo real**: Estado del viaje (esperando, en progreso, finalizado)
- 💬 **Chat con conductor**: Comunicación directa durante el viaje
- 🔔 **Notificaciones**: Alertas sobre el estado del viaje
- 🌐 **WebView**: Integración con plataformas web cuando sea necesario

## 🛠️ Tecnologías

- **Flutter** 3.9.2+
- **Dart** 3.9.2+
- **Google Maps Flutter** ^2.5.0
- **Geolocator** ^10.1.1
- **Provider** ^6.1.2 (gestión de estado)
- **HTTP** ^1.2.2
- **SharedPreferences** ^2.2.3
- **WebView Flutter** ^4.8.0
- **Fluttertoast** ^8.2.6

## 🚀 Configuración Inicial

### Prerrequisitos

1. **Flutter SDK**: Instalado y configurado ([Guía oficial](https://docs.flutter.dev/get-started/install))
2. **Android Studio** (para desarrollo Android)
3. **Xcode** (para desarrollo iOS, solo en macOS)
4. **Claves de Google Maps API** para Android e iOS

### 1. Clonar el Repositorio

```bash
git clone https://github.com/Giovanni1906/pavill.cliente.multiplataforma.git
cd pavill.cliente.multiplataforma
```

### 2. Instalar Dependencias

```bash
flutter pub get
```

## 🔑 Configuración de Claves y Secretos

### Android

#### A. Google Maps API Key

1. **Crear archivo de configuración local**:
   ```bash
   cp android/local.properties.example android/local.properties
   ```

2. **Editar `android/local.properties`**:
   ```properties
   sdk.dir=/ruta/a/tu/Android/Sdk
   MAPS_API_KEY=TU_CLAVE_DE_GOOGLE_MAPS_ANDROID
   ```

3. **Ya está configurado en el proyecto**:
   - ✅ `android/app/build.gradle.kts` lee la clave desde `local.properties`
   - ✅ `AndroidManifest.xml` incluye el meta-data con `${MAPS_API_KEY}`
   - ✅ Permisos de ubicación agregados (`ACCESS_FINE_LOCATION`, `ACCESS_COARSE_LOCATION`)

#### B. Keystore para Firma de APK

1. **Crear tu keystore** (si no lo tienes):
   ```bash
   keytool -genkey -v -keystore android/app/keystore/pavill-release-key.jks \
     -keyalg RSA -keysize 2048 -validity 10000 -alias pavill-key-alias
   ```

2. **Crear archivo de propiedades del keystore**:
   ```bash
   cp android/key.properties.example android/key.properties
   ```

3. **Editar `android/key.properties`**:
   ```properties
   storeFile=app/keystore/pavill-release-key.jks
   storePassword=TU_PASSWORD_DE_KEYSTORE
   keyAlias=pavill-key-alias
   keyPassword=TU_PASSWORD_DE_CLAVE
   ```

4. **Ya está configurado en el proyecto**:
   - ✅ `android/app/build.gradle.kts` usa el keystore para builds de debug y release
   - ✅ Esto es necesario para que las claves de Maps API con restricciones funcionen

### iOS

#### A. Google Maps API Key

1. **Crear archivo de secretos**:
   ```bash
   cp ios/Flutter/Secrets.xcconfig.example ios/Flutter/Secrets.xcconfig
   ```

2. **Editar `ios/Flutter/Secrets.xcconfig`**:
   ```
   MAPS_API_KEY=TU_CLAVE_DE_GOOGLE_MAPS_IOS
   ```

3. **Ya está configurado en el proyecto**:
   - ✅ `ios/Flutter/Debug.xcconfig` incluye `Secrets.xcconfig`
   - ✅ `ios/Flutter/Release.xcconfig` incluye `Secrets.xcconfig`
   - ✅ `ios/Runner/Info.plist` referencia `$(MAPS_API_KEY)`

#### B. Permisos de Ubicación

Ya están configurados en `ios/Runner/Info.plist`. Si necesitas personalizar los mensajes, edita:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Necesitamos tu ubicación para mostrarte dónde estás y ayudarte a solicitar un taxi</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Necesitamos tu ubicación para el seguimiento del viaje</string>
```

## 📱 Compilar y Ejecutar

### Android

```bash
# Modo debug
flutter run

# Modo release
flutter build apk --release
# O para App Bundle
flutter build appbundle --release
```

Los archivos generados estarán en:
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`

### iOS

```bash
# Modo debug (requiere dispositivo o simulador)
flutter run

# Modo release (requiere certificados de Apple)
flutter build ios --release
```

Abre `ios/Runner.xcworkspace` en Xcode para firmar y distribuir la app.

## 📂 Estructura del Proyecto

```
lib/
├── main.dart                      # Punto de entrada
├── core/                          # Lógica core y servicios
│   ├── services/                  # Servicios (API, ubicación, etc.)
│   ├── models/                    # Modelos de datos
│   └── providers/                 # Providers de estado
└── presentation/                  # UI y screens
    ├── screens/                   # Pantallas de la app
    │   ├── map_screen.dart        # Pantalla principal con mapa
    │   ├── waiting_screen.dart    # Esperando conductor
    │   └── progress_screen.dart   # Viaje en progreso
    └── widgets/                   # Componentes reutilizables
```

## 🔒 Seguridad

**IMPORTANTE**: Los siguientes archivos contienen información sensible y NO deben ser commitados:

- ❌ `android/local.properties`
- ❌ `android/key.properties`
- ❌ `android/app/keystore/*.jks`
- ❌ `ios/Flutter/Secrets.xcconfig`

Estos archivos ya están incluidos en `.gitignore`.

## 📝 Notas Importantes

### Google Maps API

- Necesitas **2 claves diferentes**: una para Android y otra para iOS
- Cada clave debe tener las restricciones apropiadas:
  - **Android**: Restringida por huella SHA-1 del keystore
  - **iOS**: Restringida por Bundle ID
- Activa las APIs necesarias en Google Cloud Console:
  - Maps SDK for Android
  - Maps SDK for iOS
  - (Opcionalmente) Places API, Directions API

### Keystore Android

- El proyecto está configurado para usar el **mismo keystore** en debug y release
- Esto es necesario para que las claves de Maps API funcionen correctamente
- Guarda tu keystore y passwords de forma segura (nunca en el repositorio)

### Permisos

- **Android**: Los permisos de ubicación se solicitan en runtime
- **iOS**: Los mensajes de permisos deben ser claros y específicos

## 🐛 Troubleshooting

### "Google Maps no se muestra en Android"
- Verifica que `MAPS_API_KEY` esté correctamente configurado en `local.properties`
- Asegúrate de que la huella SHA-1 de tu keystore esté registrada en Google Cloud Console
- Revisa los logs: `adb logcat | grep -i maps`

### "Google Maps no se muestra en iOS"
- Verifica que `MAPS_API_KEY` esté en `Secrets.xcconfig`
- Asegúrate de que el Bundle ID esté autorizado en Google Cloud Console
- Limpia el build: `flutter clean && flutter pub get`

### "Error al compilar en Android"
- Verifica que `key.properties` exista y tenga las rutas correctas
- Asegúrate de que el archivo keystore exista en la ubicación especificada
