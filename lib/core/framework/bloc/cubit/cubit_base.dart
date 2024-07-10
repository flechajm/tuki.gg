import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../errors/failures/failure.dart';

export '../../../errors/failures/failure.dart';

abstract class CubitBase<Entity, State> extends Cubit<State> {
  CubitBase(super.initialState);

  State getState(Either<Failure, Entity> eitherData);
}
