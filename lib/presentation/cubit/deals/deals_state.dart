part of 'deals_cubit.dart';

abstract class DealsState {
  const DealsState();
}

class DealsInitial extends DealsState {}

class DealsLoading extends DealsState {}

class DealsLoaded extends DealsState {
  final List<DealInfo> dealsResponse;

  const DealsLoaded(this.dealsResponse);
}

class DealsError extends DealsState {
  final Failure failure;
  const DealsError(this.failure);
}
