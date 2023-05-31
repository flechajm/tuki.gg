class ServerException implements Exception {
  final int code;
  final String message;

  const ServerException({
    required this.code,
    required this.message,
  });
}
