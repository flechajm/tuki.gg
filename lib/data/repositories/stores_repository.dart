import 'package:dartz/dartz.dart';

import '../../domain/entities/store.dart';
import '../../domain/repositories/istores_repository.dart';
import '../datasources/stores_datasource.dart';
import 'base/repository.dart';

class StoresRepository extends Repository<StoresDataSource> implements IStoresRepository {
  StoresRepository({
    required StoresDataSource dataSource,
  }) : super(dataSource: dataSource);

  @override
  Future<Either<Failure, List<Store>>> getStores() async {
    return executeAction<List<Store>>(() async => await dataSource.getStores());
  }
}
