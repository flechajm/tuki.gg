import 'dart:convert';

import 'package:global_configuration/global_configuration.dart';

import '../../../core/http/http_client.dart';
import '../../domain/entities/deal_info.dart';
import '../../domain/usecases/deal_info/params/params_deal.dart';
import '../models/deal_info/deal_info_model.dart';
import 'base/datasource.dart';
import 'interfaces/ideals_datasource.dart';

class DealsDataSource extends DataSource implements IDealsDataSource {
  final String _url = GlobalConfiguration().getDeepValue("api:url");
  final String _endpoint = GlobalConfiguration().getDeepValue("api:endpoints:deals");

  DealsDataSource({
    required HttpClient client,
  }) : super(client: client);

  @override
  Future<List<DealInfo>> getDeals(ParamsDeal params) async {
    String fixedEndpoint = "$_endpoint${getUrl(params)}";

    String data = await client.get(
      url: "$_url/$fixedEndpoint",
    );

    List dataList = json.decode(data);
    return dataList.map((deal) => DealInfoModel.fromJson(deal)).toList();
  }

  static String getUrl(ParamsDeal params, {bool completeUrl = false}) {
    String storesId = params.storeIds != null ? "storeID=${params.storeIds}&" : "";
    String pageNumber = "pageNumber=${params.pageNumber.toString()}&";
    String pageSize = "pageSize=${params.pageSize.toString()}&";
    String price = "lowerPrice=${params.priceRange.start.toStringAsFixed(0)}&upperPrice=${params.priceRange.end.toStringAsFixed(0)}&";
    String metacriticScore = params.metacriticScore > 0 ? "metacritic=${params.metacriticScore.toStringAsFixed(0)}&" : "";
    String steammRating = params.steamRating > 0 ? "steamRating=${params.steamRating.toStringAsFixed(0)}&" : "";
    String title = params.gameTitle.isNotEmpty ? "title=${params.gameTitle}&" : "";
    String aaaGame = params.aaa ? "AAA=1&" : "AAA=0&";
    String onSale = params.onSale ? "onSale=1&" : "onSale=0&";
    String sortBy = params.sortBy.isNotEmpty ? "sortBy=${params.sortBy}&" : "";
    String desc = params.desc ? "desc=1&" : "desc=0&";

    String fixedEndpoint = "$storesId$title$pageNumber$pageSize$price$metacriticScore$steammRating$aaaGame$onSale$sortBy$desc";

    if (completeUrl) {
      fixedEndpoint = "https://www.cheapshark.com/api/1.0/deals?$fixedEndpoint";
    }

    return fixedEndpoint;
  }
}
