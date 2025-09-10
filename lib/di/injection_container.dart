import 'package:dio_jwt_demo/core/network/api_client.dart';
import 'package:dio_jwt_demo/core/util/api_constants.dart';
import 'package:dio_jwt_demo/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:dio_jwt_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../features/auth/data/data_source/auth_remote_data_source.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/use_case/login_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 1. Register the Dio instance first, with its BaseOptions
  sl.registerLazySingleton<Dio>(
        () => Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': "application/json",
          'Accept': 'application/json',
        },
      ),
    ),
  );
  // Dio client
  sl.registerLazySingleton<ApiClient>(() => ApiClient(dio: sl<Dio>()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );

  // login Use cases
  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));
  // auth bloc
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));// new instance each time
}
