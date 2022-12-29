import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // //! Features - album_search
  // // Bloc
  // serviceLocator.registerFactory(() => AlbumBloc(getAlbum: serviceLocator()));

  // //UseCases
  // serviceLocator.registerLazySingleton(() => GetAlbumUseCase(serviceLocator()));

  // //Respository
  // serviceLocator.registerLazySingleton<AlbumRepository>(() => AlbumRepositoryImpl(
  //     localDataSource: serviceLocator(), networkInfo: serviceLocator(), remoteDataSource: serviceLocator()));

  // //Data sources
  // serviceLocator
  //     .registerLazySingleton<AlbumRemoteDataSource>(() => AlbumRemoteDataSourceImpl(client: serviceLocator()));
  // serviceLocator
  //     .registerLazySingleton<AlbumLocalDataSource>(() => AlbumLocalDataSourceImpl(sharedPreferences: serviceLocator()));

  // //! Core
  // serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(serviceLocator()));

  //! External
  final hivedb = await Hive.initFlutter();
  serviceLocator.registerLazySingleton(() => hivedb);
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(() => Connectivity());
}
