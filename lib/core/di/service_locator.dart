import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:groceries/core/network/dio_client.dart';
import 'package:groceries/core/theme/theme_bloc.dart';
import 'package:groceries/features/authentication/data/datasource/auth_local_datasource.dart';
import 'package:groceries/features/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:groceries/features/authentication/data/datasource/auth_remote_datasource_imp.dart';
import 'package:groceries/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:groceries/features/authentication/domain/repository/authRepository.dart';
import 'package:groceries/features/authentication/domain/usecase/get_user_usecase.dart';
import 'package:groceries/features/authentication/domain/usecase/login_usecase.dart';
import 'package:groceries/features/authentication/domain/usecase/logout_usecase.dart';
import 'package:groceries/features/authentication/domain/usecase/register_usecase.dart';
import 'package:groceries/features/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/logout/logout_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/register/register_bloc.dart';
import 'package:groceries/features/authentication/presentation/bloc/user/user_bloc.dart';
import 'package:groceries/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:groceries/features/cart/data/datasource/cart_remote_datasource_impl.dart';
import 'package:groceries/features/cart/data/repository/cart_repository_impl.dart';
import 'package:groceries/features/cart/domain/repositories/cart_repository.dart';
import 'package:groceries/features/cart/domain/usecase/add_cart_usecase.dart';
import 'package:groceries/features/cart/domain/usecase/delete_cart_usecase.dart';
import 'package:groceries/features/cart/domain/usecase/get_cart_usecase.dart';
import 'package:groceries/features/cart/domain/usecase/post_cart_usecase.dart';
import 'package:groceries/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:groceries/features/home/data/datasource/category_remote_datasource.dart';
import 'package:groceries/features/home/data/datasource/catefory_remote_dataosource_impl.dart';
import 'package:groceries/features/home/data/datasource/product_remote_datasource.dart';
import 'package:groceries/features/home/data/datasource/product_remote_datasource_impl.dart';
import 'package:groceries/features/home/data/repository/category_repository_impl.dart';
import 'package:groceries/features/home/data/repository/product_repository_impl.dart';
import 'package:groceries/features/home/domain/repository/category_repository.dart';
import 'package:groceries/features/home/domain/repository/product_repository.dart';
import 'package:groceries/features/home/domain/usecase/fetch_category_products_usecase.dart' show FetchCategoryWithProductsUseCase;
import 'package:groceries/features/home/domain/usecase/fetch_category_usecase.dart';
import 'package:groceries/features/home/domain/usecase/fetch_product_usecase.dart';
import 'package:groceries/features/home/domain/usecase/get_all_products_usecase.dart';
import 'package:groceries/features/home/domain/usecase/review_usecase.dart';
import 'package:groceries/features/home/domain/usecase/toggle_favorite.dart';
import 'package:groceries/features/home/domain/usecase/toggle_favorite_usecase.dart';
import 'package:groceries/features/home/presentation/bloc/products/products_bloc.dart';

final sl = GetIt.instance;

Future<void> setUp() async {
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasourceImpl());
  sl.registerLazySingleton<DioClient>(() => DioClient(sl(), sl<AuthLocalDatasource>()));

  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImp(sl()));
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl( sl()));
  sl.registerLazySingleton<CategoryRemoteDataSource>(() => CategoryRemoteDataSourceImpl( sl()));
  sl.registerLazySingleton<CartRemoteDataSource>(() => CartRemoteDataSourceImpl(dioClient: sl()));

  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl<AuthRemoteDataSource>(), sl<AuthLocalDatasource>()),
  );
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(sl<ProductRemoteDataSource>()));
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(sl<CategoryRemoteDataSource>()));
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(authRepository: sl()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(authRepository: sl()));
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(authRepository: sl()));
  sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(authRepository: sl()));

  sl.registerLazySingleton<FetchProductsUseCase>(() => FetchProductsUseCase(sl<ProductRepository>()));
  sl.registerLazySingleton<ToggleFavoriteUseCase>(() => ToggleFavoriteUseCase(sl<ProductRepository>()));
  sl.registerLazySingleton<FetchFavoritesUseCase>(() => FetchFavoritesUseCase(sl<ProductRepository>()));
  sl.registerLazySingleton<SubmitReviewUseCase>(() => SubmitReviewUseCase(sl<ProductRepository>()));
  sl.registerLazySingleton<FetchProductUseCase>(() => FetchProductUseCase(sl<ProductRepository>()));

  sl.registerLazySingleton<FetchAllCategoriesUseCase>(() => FetchAllCategoriesUseCase(sl<CategoryRepository>()));
  sl.registerLazySingleton<FetchCategoryWithProductsUseCase>(() => FetchCategoryWithProductsUseCase(sl<CategoryRepository>()));

  sl.registerLazySingleton(() => GetCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => AddCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => UpdateCartUseCase(sl<CartRepository>()));
  sl.registerLazySingleton(() => DeleteCartUseCase(sl<CartRepository>()));

  sl.registerLazySingleton(() => ThemeBloc());

  sl.registerFactory(() => RegisterBloc(sl<RegisterUseCase>()));
  sl.registerFactory(() => LoginBloc(sl<LoginUseCase>()));
  sl.registerFactory(() => LogoutBloc(sl<LogoutUseCase>()));
  sl.registerFactory(() => ProductBloc(
      productRepository: sl<ProductRepository>(),
      categoryRepository: sl<CategoryRepository>()
  ));
  sl.registerFactory(() => UserProfileBloc(getUserUseCase: sl<GetUserUseCase>()));
  sl.registerFactory(() => CartBloc(
      cartRepository: sl<CartRepository>()
  ));
}
