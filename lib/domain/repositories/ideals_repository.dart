import 'package:dartz/dartz.dart';

import '../../core/errors/failures/failure.dart';
import '../entities/deal_info.dart';
import '../usecases/deal_info/params/params_deal.dart';

abstract class IDealsRepository {
  Future<Either<Failure, List<DealInfo>>> getDeals(ParamsDeal params);
}
