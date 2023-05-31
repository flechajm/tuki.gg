import 'package:dartz/dartz.dart';

import '../../core/errors/failures/failure.dart';
import '../entities/store.dart';

abstract class IStoresRepository {
  Future<Either<Failure, List<Store>>> getStores();
}
