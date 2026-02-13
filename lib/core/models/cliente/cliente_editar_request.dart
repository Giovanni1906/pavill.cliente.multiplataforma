class ClienteEditarRequest {
  final String clienteId;
  final String clienteNumeroDocumento;
  final String clienteNombre;
  final String clienteEmail;
  final String clienteCelular;

  const ClienteEditarRequest({
    required this.clienteId,
    required this.clienteNumeroDocumento,
    required this.clienteNombre,
    required this.clienteEmail,
    required this.clienteCelular,
  });

  Map<String, String> toMap() {
    return {
      "ClienteId": clienteId,
      "ClienteNumeroDocumento": clienteNumeroDocumento,
      "ClienteNombre": clienteNombre,
      "ClienteEmail": clienteEmail,
      "ClienteCelular": clienteCelular,
    };
  }
}
