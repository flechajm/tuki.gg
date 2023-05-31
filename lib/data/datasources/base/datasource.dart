import '../../../core/http/http_client.dart';

abstract class DataSource {
  final HttpClient client;

  DataSource({required this.client});
}
