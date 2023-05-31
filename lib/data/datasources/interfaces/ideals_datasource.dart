import '../../../domain/entities/deal_info.dart';
import '../../../domain/usecases/deal_info/params/params_deal.dart';

abstract class IDealsDataSource {
  Future<List<DealInfo>> getDeals(ParamsDeal params);
}
