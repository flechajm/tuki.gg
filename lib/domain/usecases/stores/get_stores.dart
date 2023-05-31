import 'package:dartz/dartz.dart';

import '../../../core/framework/bloc/usecase/iusecase.dart';
import '../../entities/store.dart';
import '../../repositories/istores_repository.dart';

class GetStores implements IUseCase<List<Store>, void> {
  final IStoresRepository _repository;

  GetStores(this._repository);

  @override
  Future<Either<Failure, List<Store>>> call(noParams) async {
    return await _repository.getStores();
  }
}
