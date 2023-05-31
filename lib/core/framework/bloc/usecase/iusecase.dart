import 'package:dartz/dartz.dart';

import '../../../errors/failures/failure.dart';

export '../../../errors/failures/failure.dart';

abstract class IUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
