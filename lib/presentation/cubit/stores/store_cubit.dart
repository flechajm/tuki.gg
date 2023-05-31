import 'package:dartz/dartz.dart';

import '../../../core/framework/bloc/cubit/cubit_base.dart';
import '../../../core/framework/bloc/usecase/usecase_params.dart';
import '../../../domain/entities/store.dart';
import '../../../domain/usecases/stores/get_stores.dart';

part 'store_state.dart';

class StoresCubit extends CubitBase<List<Store>, StoresState> {
  final GetStores _getStore;

  StoresCubit(this._getStore) : super(StoresInitial());

  void getStoreLsit() async {
    emit(StoresLoading());
    final eitherData = await _getStore(NoParams());
    if (isClosed) return;
    emit(getState(eitherData));
  }

  @override
  StoresState getState(Either<Failure, List<Store>> eitherData) {
    return eitherData.fold(
      (failure) => StoresError(failure),
      (data) => StoresLoaded(data),
    );
  }
}
