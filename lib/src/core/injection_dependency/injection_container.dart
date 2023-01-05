import 'package:get_it/get_it.dart';
import 'package:network_info/network_info.dart';
import 'package:local_datasource/local_datasource.dart';
import 'package:offline_first_workflow/src/features/checking_internet/domain/repositories/check_internet_repository.dart';
import 'package:remote_datasource/remote_datasource.dart';

import 'package:offline_first_workflow/src/features/checking_internet/domain/usecases/check_internet.dart';
import 'package:offline_first_workflow/src/features/checking_internet/domain/usecases/on_connectivity_change.dart';
import 'package:offline_first_workflow/src/features/checking_internet/presentation/bloc/check_internet/check_internet_bloc.dart';
import 'package:offline_first_workflow/src/features/badge/data/datasources/badge_local_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/data/datasources/badge_remote_datasource.dart';
import 'package:offline_first_workflow/src/features/badge/domain/repositories/badge_repository.dart';
import 'package:offline_first_workflow/src/features/badge/domain/usecases/get_divisa.dart';
import 'package:offline_first_workflow/src/features/badge/presentation/bloc/badge_bloc/badge_bloc.dart';

import '../../features/badge/data/dtos/badge_dto_local.dart';

final serviceLocator = GetIt.instance;

List<HiveConfig> boxes = [
  HiveConfig(
    adaptar: BadgeDtoLocalAdapter(),
    nameOpenBox: "badge",
    box: true,
  ),
];

Future<void> init() async {
  // // Bloc
  serviceLocator.registerFactory(() => BadgeBloc(serviceLocator()));
  serviceLocator.registerFactory(() => CheckInternetBloc(
        serviceLocator(),
        serviceLocator(),
      ));

  //UseCases
  serviceLocator
      .registerLazySingleton(() => GetDivisa(repository: serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => CheckInternet(repository: serviceLocator()));

  serviceLocator.registerLazySingleton(
      () => OnConnectivityChanged(repository: serviceLocator()));

  //Respository
  serviceLocator.registerLazySingleton<IBadgeRepository>(
    () => BadgeRepositoryImpl(
      remoteData: serviceLocator(),
      localData: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<ICheckInternetRepository>(
      () => CheckInternetRepositoryImpl(networkInfo: serviceLocator()));

  //Remote Data Sources
  serviceLocator.registerLazySingleton<IBadgeRemoteDataSource>(
      () => BadgeRemoteDataSourceImpl(repository: serviceLocator()));

  // Local Data Sources
  serviceLocator.registerLazySingleton<IBadgeLocalDataSource>(
      () => BadgeLocalDataSourceImpl(repository: serviceLocator()));

  serviceLocator.registerLazySingleton<RemoteRepository>(
      () => RemoteRepository(package: serviceLocator()));

  serviceLocator.registerLazySingleton<DioRepository>(
      () => DioRepository(package: serviceLocator()));

  serviceLocator.registerLazySingleton<DioDatasource>(
      () => DioDatasource(baseUrl: "https://currency-exchange.p.rapidapi.com"));

  serviceLocator.registerLazySingleton<LocalRepository>(
      () => LocalRepository(package: serviceLocator(), objects: boxes));

  serviceLocator.registerLazySingleton<HiveRepository>(
      () => HiveRepository(datasource: serviceLocator()));

  serviceLocator.registerLazySingleton<HiveDatasource>(
    () => HiveDatasource(),
  );

  serviceLocator.registerLazySingleton<INetworkInfoRepository>(
      () => NetworkInfoRepositoryImpl());
}
