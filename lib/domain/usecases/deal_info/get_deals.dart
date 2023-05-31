import 'package:dartz/dartz.dart';

import '../../../core/framework/bloc/usecase/iusecase.dart';
import '../../entities/deal_info.dart';
import '../../repositories/ideals_repository.dart';
import 'params/params_deal.dart';

class GetDeals implements IUseCase<List<DealInfo>, ParamsDeal> {
  final IDealsRepository _repository;

  GetDeals(this._repository);

  @override
  Future<Either<Failure, List<DealInfo>>> call(params) async {
    return await _repository.getDeals(params);
  }
}
