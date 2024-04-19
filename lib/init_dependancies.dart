import 'package:blog_app/core/credentials/credentials.dart';
import 'package:blog_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:blog_app/features/auth/data/repo_implementation/auth_repo_implementation.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/utils/cubits/app_user/app_user_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependancies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: Credentials.supabaseUrl, anonKey: Credentials.anonKey);
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);
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
