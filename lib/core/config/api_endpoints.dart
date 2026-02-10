class ApiEndpoints {
  // Bases
  static const String legacyBaseUrl =
      "http://rtpavillv3.ddns.net:8014/apptaxipavill-cliente-v300/webservice";
  static const String apiBaseUrl =
      "https://pavill.lat:1000/api/v1";

  // Dominios
  static const String clienteBase = "$apiBaseUrl/cliente";

  // Generales
  static const String apiHealth = "$apiBaseUrl/test/health";

  // 👤 Endpoints de Clientes
  static const String clienteRegistrar = "$clienteBase/registrar";
  static const String clienteAcceder = "$clienteBase/acceder";
  static const String clienteEditar = "$clienteBase/editar";
  static const String clienteEditarContrasena = "$clienteBase/editar-contrasena";
  static const String clienteRecuperarContrasena = "$clienteBase/recuperar";
  static const String clienteVerificarCelular = "$clienteBase/verificar-celular";
  static const String clienteReportarUbicacion = "$clienteBase/reportar-ubicacion";
  static const String clienteReporteUbicacionObtener = "$clienteBase/reporte-ubicacion-obtener";
  static const String clienteActualizarCoordenada = "$clienteBase/actualizar-coordenada";
  static const String clienteCentralActualizarContrasena = "$clienteBase/central/actualizar-contrasena";
  static const String clienteCentralActualizarEstado = "$clienteBase/central/actualizar-estado";
  static const String clienteObtenerRegistrados = "$clienteBase/obtener-registrados";

  // Legacy (PHP)
  static const String legacyLogin = "$legacyBaseUrl/JnCliente.php";
  static const String php_clienteRecuperarContrasena = "$legacyLogin?Accion=RecuperarContrasena";
}