import 'package:dartz/dartz.dart';

import '../../../core/framework/bloc/cubit/cubit_base.dart';
import '../../../domain/entities/deal_info.dart';
import '../../../domain/usecases/deal_info/get_deals.dart';
import '../../../domain/usecases/deal_info/params/params_deal.dart';

part 'deals_state.dart';

class DealsCubit extends CubitBase<List<DealInfo>, DealsState> {
  final GetDeals _getDeals;

  DealsCubit(this._getDeals) : super(DealsInitial());

  void getDeals(ParamsDeal params) async {
    emit(DealsLoading());
    final eitherData = await _getDeals(params);
    if (isClosed) return;
    emit(getState(eitherData));
  }

  @override
  DealsState getState(Either<Failure, List<DealInfo>> eitherData) {
    return eitherData.fold(
      (failure) => DealsError(failure),
      (data) => DealsLoaded(data),
    );
  }
}
