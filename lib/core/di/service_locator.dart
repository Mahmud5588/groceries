import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:groceries/core/network/dio_client.dart';
import 'package:groceries/core/theme/theme_bloc.dart';
import 'package:groceries/features/authentication/data/datasource/auth_local_datasource.dart';
import 'package:groceries/features/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:groceries/features/authentication/data/datasource/auth_remote_datasource_imp.dart';
import 'package:groceries/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:groceries/features/authentication/domain/repository/authRepository.dart';
import 'package:groceries/features/authentication/domain/usecase/email_resend_usecase.dart';
import 'package:groceries/features/authentication/domain/usecase/get_user_usecase.dart';
import 'package:groceries/features/authentication/domain/usecase/login_usecase.dart';
import 'package:groceries/features/authentication/domain/usecase/logout_usecase.dart';
import 'package:groceries/features/authentication/domain/usecase/register_usecase.dart';
import 'package:groceries/features/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/logout/logout_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/register/register_bloc.dart';

final sl = GetIt.instance;

Future<void> setUp() async {
  // Core dependencies
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DioClient(sl()));

  sl.registerLazySingleton<ThemeBloc>(() => ThemeBloc());


  //local
  sl.registerLazySingleton<AuthLocalDatasource>(
        () => AuthLocalDatasourceImpl(),
  );


  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImp(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Authentication Use Cases
  sl.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(authRepository: sl()),
  );
  sl.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(authRepository: sl()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
        () => LogoutUseCase(authRepository: sl()),
  );
  sl.registerLazySingleton<EmailResendUseCase>(
        () => EmailResendUseCase(authRepository: sl()),
  );
  sl.registerLazySingleton<GetUserUseCase>(
        () => GetUserUseCase(authRepository: sl()),
  );

  // Authentication BLoCs
  sl.registerFactory(() => RegisterBloc(sl()));
  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => LogoutBloc(sl()));
}
