import 'package:blog_app/core/credentials/credentials.dart';
import 'package:blog_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:blog_app/features/auth/data/repo_implementation/auth_repo_implementation.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/internet/connection_checker.dart';
import 'core/utils/cubits/app_user/app_user_cubit.dart';
import 'features/blog/data/datasource/blog_local_data_source.dart';
import 'features/blog/data/datasource/blog_remote_datasource.dart';
import 'features/blog/data/repo_imp/blog_repository_impl.dart';
import 'features/blog/domain/repository/blog_repository.dart';
import 'features/blog/domain/usecase/get_all_blog.dart';
import 'features/blog/domain/usecase/update_blog.dart';
import 'features/blog/presentation/bloc/blog_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: Credentials.supabaseUrl, anonKey: Credentials.anonKey);
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'blogs'),
  );
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator<SupabaseClient>()))
    ..registerFactory<AuthRepository>(
        () => AuthRepoImplementation(serviceLocator<AuthRemoteDataSource>()))
    ..registerFactory(() => UserSignup(serviceLocator<AuthRepository>()))
    ..registerFactory(() => UserLogin(serviceLocator<AuthRepository>()))
    ..registerFactory(() => GetCurrentUser(serviceLocator<AuthRepository>()))
    ..registerLazySingleton(() => AppUserCubit())
    ..registerLazySingleton(() => AuthBloc(serviceLocator<GetCurrentUser>(),
        userSignup: serviceLocator<UserSignup>(),
        userLogin: serviceLocator<UserLogin>(),
        appCubit: serviceLocator<AppUserCubit>()));
}

void _initBlog() {
  // Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton<BlogBloc>(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
