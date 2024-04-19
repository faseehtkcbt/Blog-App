import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/init_dependancies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/app_user/app_user_cubit.dart';

class BlocProviders {
  BlocProviders._();

  static final providers = [
    BlocProvider<AuthBloc>(create: (context) => serviceLocator<AuthBloc>()),
    BlocProvider<AppUserCubit>(
        create: (context) => serviceLocator<AppUserCubit>())
  ];
}
