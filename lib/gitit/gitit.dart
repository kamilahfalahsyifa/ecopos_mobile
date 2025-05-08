import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ecopos/data/datasource/authentication_datasource.dart';
import 'package:ecopos/data/repository/authentication_repository.dart';
import 'package:ecopos/util/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> getItInit() async {
  await _initComponents();
  await _initDatasources(); // <- sudah benar
  _initRepositories();
}

Future<void> _initComponents() async {
  locator.registerSingleton<Dio>(DioProvider.createDioWithoutHeader());
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

Future<void> _initDatasources() async { // <- sudah benar
  locator.registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
}

void _initRepositories() {
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
}
