import 'package:get_it/get_it.dart';
import 'package:new_app/feature/auth/data/repo/auth_repo.dart';
import 'package:new_app/feature/auth/data/repo/auth_repo_implement.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future setup() async {
    getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImplement());
  }
}
