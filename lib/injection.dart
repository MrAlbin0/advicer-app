import 'package:advicer/application/advicer/advicer_bloc.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:advicer/domain/usecases/reposetories/advicer_reposetory.dart';
import 'package:advicer/infrastructure/repositories/advicer_repositorys_impl.dart';
import 'package:advicer/infrastructure/repositories/datasources/advicer_remote_datasources.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.asNewInstance(); // sl == serviceLocator

Future<void> init() async {

  //! Blocs
  /// wird jedes mal neu erstellt, wenn Bloc benutzt wird
  sl.registerFactory(() => AdvicerBloc(usecases: sl()));

  //! Usecases
  /// wird erst erstellt wenn es gebraucht wird
  sl.registerLazySingleton(() => AdvicerUsecases(advicerReposetory: sl()));

  //! Repos
  sl.registerLazySingleton<AdvicerReposetory>(() => AdvicerRepositorysImpl(advicerRemoteDatasources: sl()));

  //! Datasources
  sl.registerLazySingleton<AdvicerRemoteDatasources>(() => AdvicerRemoteDatasourcesImpl(client: sl()));

  //!extern
  /// die Klassen die wir nicht selber gemacht haben
  sl.registerLazySingleton(() => http.Client());

}