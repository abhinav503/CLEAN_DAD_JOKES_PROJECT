import 'package:degreed/features/home/data/data_source/jokes_data_source_repository.dart';
import 'package:degreed/features/home/data/data_source/jokes_data_source_repository_impl.dart';
import 'package:degreed/features/home/data/repository_impl/jokes_repository_impl.dart';
import 'package:degreed/features/home/domain/repository/dad_jokes_repository.dart';
import 'package:degreed/features/home/domain/usecase/get_dad_jokes_usecase.dart';
import 'package:degreed/features/home/domain/usecase/get_search_dad_jokes_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:degreed/core/network_repository/network_repository.dart';
import 'package:degreed/core/network_repository/network_repository_impl.dart';

final sl = GetIt.instance;

injectionContainer() {
  sl.registerLazySingleton<NetworkRepository>(() => NetworkRepositoryImpl());
  sl.registerLazySingleton<DadJokesDataSourceRepository>(
      () => DadJokesDataSourceRepositoryImpl(networkRepository: sl()));
  sl.registerLazySingleton<DadJokesRepository>(
      () => DadJokesRepositoryImpl(dadJokesDataSourceRepository: sl()));
  sl.registerLazySingleton(() => GetDadJokesDataUsecase(sl()));
  sl.registerLazySingleton(() => GetSearchDadJokesUsecase(sl()));
}
