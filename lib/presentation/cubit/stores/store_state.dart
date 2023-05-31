part of 'store_cubit.dart';

abstract class StoresState {
  const StoresState();
}

class StoresInitial extends StoresState {}

class StoresLoading extends StoresState {}

class StoresLoaded extends StoresState {
  final List<Store> storeResponse;

  const StoresLoaded(this.storeResponse);
}

class StoresError extends StoresState {
  final Failure failure;
  const StoresError(this.failure);
}
