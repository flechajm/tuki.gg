import 'package:dartz/dartz.dart';

import '../../domain/entities/deal_info.dart';
import '../../domain/repositories/ideals_repository.dart';
import '../../domain/usecases/deal_info/params/params_deal.dart';
import '../datasources/deals_datasource.dart';
import 'base/repository.dart';

class DealsRepository extends Repository<DealsDataSource> implements IDealsRepository {
  DealsRepository({
    required super.dataSource,
  });

  @override
  Future<Either<Failure, List<DealInfo>>> getDeals(ParamsDeal params) async {
    return executeAction<List<DealInfo>>(() async => await dataSource.getDeals(params));
  }
}
