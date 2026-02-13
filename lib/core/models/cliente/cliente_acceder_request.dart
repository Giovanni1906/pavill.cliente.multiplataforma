class ClienteAccederRequest {
  final String clienteEmail;
  final String clienteContrasena;

  const ClienteAccederRequest({
    required this.clienteEmail,
    required this.clienteContrasena,
  });

  Map<String, String> toMap() {
    return {
      "ClienteEmail": clienteEmail,
      "ClienteContrasena": clienteContrasena,
    };
  }
}
