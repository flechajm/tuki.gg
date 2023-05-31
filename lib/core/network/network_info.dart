import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'interface/inetwork_info.dart';

class NetworkInfo implements INetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfo(this.connectionChecker);

  @override
  Future<bool> get isConnected async => await connectionChecker.hasConnection;
}
