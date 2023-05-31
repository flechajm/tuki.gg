class NoInternetConnectionException implements Exception {
  static const String _message = "No internet connection";
  const NoInternetConnectionException();

  @override
  String toString() => _message;
}
