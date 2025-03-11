import 'package:apparel_360/core/network/network_call_interface.dart';
import 'package:apparel_360/core/network/repository.dart';
import 'package:get_it/get_it.dart';
import 'package:apparel_360/core/network/base_client.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Register BaseClient as a singleton
  getIt.registerLazySingleton<NetworkCallInterface>(() => BaseClient());

  // Register NetworkRepository with BaseClient dependency
  getIt.registerLazySingleton<NetworkRepository>(
      () => NetworkRepository(getIt<NetworkCallInterface>()));
}
