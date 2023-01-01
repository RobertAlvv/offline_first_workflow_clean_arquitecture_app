import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:remote_datasource/remote_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/data/datasources/badge_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/domain/repositories/badge_repository.dart';
import 'package:offline_first_workflow/src/features/badge/domain/usecases/get_divisa.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/bloc/badge_bloc/badge_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // //! Features - album_search
  // // Bloc

  serviceLocator.registerFactory(() => BadgeBloc(serviceLocator()));

  //UseCases
  serviceLocator
      .registerLazySingleton(() => GetDivisa(repository: serviceLocator()));

  //Respository
  serviceLocator.registerLazySingleton<IBadgeRepository>(
      () => BadgeRepositoryImpl(remoteData: serviceLocator()));

  //Data sources
  serviceLocator.registerLazySingleton<IBadgeDataSource>(
      () => BadgeDataSourceImpl(repository: serviceLocator()));
  // serviceLocator.registerLazySingleton<AlbumLocalDataSource>(
  //     () => AlbumLocalDataSourceImpl(sharedPreferences: serviceLocator()));

  serviceLocator.registerLazySingleton<DioRepository>(
    () => DioRepository(
      package: DioDatasource(),
    ),
  );
  //! Core
  // serviceLocator.registerLazySingleton<NetworkInfo>(
  //     () => NetworkInfoImpl(serviceLocator()));

  //! External
  final hivedb = await Hive.initFlutter();
  // serviceLocator.registerLazySingleton(() => hivedb);

  serviceLocator.registerLazySingleton(() => Connectivity());
}
