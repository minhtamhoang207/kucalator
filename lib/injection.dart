import 'package:get_it/get_it.dart';
import 'package:kucalator/ui/app_cubit.dart';
import 'package:kucalator/ui/theme/theme_cubit.dart';

import 'data/firebase/firebase_manager.dart';


final getIt = GetIt.instance;
void configureDependencies() {
  getIt.registerLazySingleton<AppCubit>(() => AppCubit());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  getIt.registerLazySingleton<FirebaseManager>(() => FirebaseManager());
}
