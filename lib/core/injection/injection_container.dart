import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valu_clone/core/routes/app_router.dart';
import 'package:valu_clone/core/theme/controller/theme_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjection() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton(() => AppRouter());
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(getIt()));

  // Per feature, register in this order:
  // 1. Data source:  getIt.registerLazySingleton<XRemoteDataSource>(() => XRemoteDataSourceImpl());
  // 2. Repository:   getIt.registerLazySingleton<XRepository>(() => XRepositoryImpl(getIt()));
  // 3. Cubit:        getIt.registerFactory<XCubit>(() => XCubit(getIt()));
}
