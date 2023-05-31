import 'dart:convert';

import 'package:http/http.dart' as http;

import '../errors/exceptions/no_internet_connection_exception.dart';
import '../errors/exceptions/server_exception.dart';
import '../network/network_info.dart';

typedef HttpRequestDelegate = Future<http.Response> Function();

class HttpClient {
  final http.Client client;
  final NetworkInfo networkInfo;

  HttpClient({
    required this.client,
    required this.networkInfo,
  });

  Future<String> get({required String url}) async {
    final Uri uri = Uri.parse(url);

    return _execute(() => client.get(
          uri,
          headers: _getHeaders(),
        ));
  }

  _checkResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 204) {
      return utf8.decode(response.bodyBytes);
    } else if (response.statusCode == 503 || response.statusCode == 502 || response.statusCode == 500) {
      throw ServerException(
        code: response.statusCode,
        message: response.statusCode.toString(),
      );
    }
  }

  Future<String> _execute(HttpRequestDelegate call) async {
    if (await networkInfo.isConnected) {
      http.Response? response = await call();
      return _checkResponse(response);
    } else {
      throw const NoInternetConnectionException();
    }
  }

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
    };
  }
}
