import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';

import '../../../core/http/http_client.dart';
import '../models/store/store_model.dart';
import 'base/datasource.dart';
import 'interfaces/istores_datasource.dart';

class StoresDataSource extends DataSource implements IStoresDataSource {
  final String _url = GlobalConfiguration().getDeepValue("api:url");
  final String _endpoint = GlobalConfiguration().getDeepValue("api:endpoints:stores");

  StoresDataSource({
    required HttpClient client,
  }) : super(client: client);

  @override
  Future<List<StoreModel>> getStores() async {
    String data = await client.get(
      url: "$_url/$_endpoint",
    );

    List dataList = json.decode(data);
    return dataList.map((store) => StoreModel.fromJson(store)).toList();
  }
}
