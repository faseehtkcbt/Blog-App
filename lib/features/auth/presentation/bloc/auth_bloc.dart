import 'package:blog_app/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/cubits/app_user/app_user_cubit.dart';
import '../../../../core/utils/entities/user.dart';
import '../../domain/usecases/current_user.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;
  final GetCurrentUser getCurrentUser;
  final AppUserCubit _appCubit;
  AuthBloc(this.getCurrentUser,
      {required UserSignup userSignup,
      required UserLogin userLogin,
      required AppUserCubit appCubit})
      : _userSignup = userSignup,
        _appCubit = appCubit,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<IsLoggedIn>(_onisLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _userSignup(UserSignUpParams(
        password: event.password, email: event.email, name: event.name));
    response.fold((failure) => emit(AuthFailure(message: failure.message)),
        (uid) => _emitAuthSuccess(uid, emit));
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final response = await _userLogin(
        UserSignInParams(password: event.password, email: event.email));
    response.fold((failure) => emit(AuthFailure(message: failure.message)),
        (uid) => _emitAuthSuccess(uid, emit));
  }

  void _onisLoggedIn(IsLoggedIn event, Emitter<AuthState> emit) async {
    final res = await getCurrentUser(NoParams());
    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (uid) => _emitAuthSuccess(uid, emit));
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    _appCubit.updateUser(user);
  }
}
