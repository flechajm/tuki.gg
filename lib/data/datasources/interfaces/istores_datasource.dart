import '../../../domain/entities/store.dart';

abstract class IStoresDataSource {
  Future<List<Store>> getStores();
}
