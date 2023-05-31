import 'package:dartz/dartz.dart';

import '../../../core/errors/exceptions/no_internet_connection_exception.dart';
import '../../../core/errors/exceptions/server_exception.dart';
import '../../../core/errors/failures/failure.dart';
import '../../../core/errors/failures/no_internet_connection_failure.dart';
import '../../datasources/base/datasource.dart';

export '../../../core/errors/exceptions/server_exception.dart';
export '../../../core/errors/failures/failure.dart';

typedef RepositoryActionDelegate<T> = Future<T> Function();

abstract class Repository<D extends DataSource> {
  final D dataSource;

  Repository({
    required this.dataSource,
  });

  Future<Either<Failure, T>> executeAction<T>(RepositoryActionDelegate<T> call) async {
    try {
      T data = await call();
      return Right(data);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          code: e.code,
          message: e.message,
        ),
      );
    } on NoInternetConnectionException catch (_) {
      return Left(NoInternetConnectionFailure());
    } on Exception catch (_) {
      return Left(NoInternetConnectionFailure());
    }
  }
}
