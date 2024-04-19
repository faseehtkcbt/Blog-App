part of 'app_user_cubit.dart';


abstract class AppUserState {}

class AppUserInitial extends AppUserState {}

class AppUserLoggedIn extends AppUserState {
  final UserEntity user;
  AppUserLoggedIn(this.user);

}
