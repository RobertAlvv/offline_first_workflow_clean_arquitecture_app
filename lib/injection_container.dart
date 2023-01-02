import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:network_info/network_info.dart';
import 'package:local_datasource/local_datasource.dart';
import 'package:remote_datasource/remote_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/data/datasources/badge_local_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/data/datasources/badge_remote_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/domain/repositories/badge_repository.dart';
import 'package:offline_first_workflow/src/features/badge/domain/usecases/get_divisa.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/bloc/badge_bloc/badge_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // // Bloc
  serviceLocator.registerFactory(() => BadgeBloc(serviceLocator()));

  //UseCases
  serviceLocator
      .registerLazySingleton(() => GetDivisa(repository: serviceLocator()));

  //Respository
  serviceLocator.registerLazySingleton<IBadgeRepository>(
    () => BadgeRepositoryImpl(
      remoteData: serviceLocator(),
      localData: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  //Remote Data Sources
  serviceLocator.registerLazySingleton<IBadgeRemoteDataSource>(
      () => BadgeRemoteDataSourceImpl(repository: serviceLocator()));

  // Local Data Sources
  serviceLocator.registerLazySingleton<IBadgeLocalDataSource>(
      () => BadgeLocalDataSourceImpl(repository: serviceLocator()));

  serviceLocator.registerLazySingleton<RemoteRepository>(() =>
      RemoteRepository(package: DioRepository(package: serviceLocator())));

  serviceLocator
      .registerLazySingleton<LocalRepository>(() => LocalRepository());

  serviceLocator.registerLazySingleton<DioDatasource>(() => DioDatasource());
  //! Core
  serviceLocator.registerLazySingleton<INetworkInfoRepository>(
      () => NetworkInfoRepositoryImpl());

  serviceLocator.registerLazySingleton(() => Connectivity());
}
