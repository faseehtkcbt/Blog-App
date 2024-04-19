import 'package:blog_app/core/failures/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/entities/user.dart';


class UserSignup implements UseCase<UserEntity, UserSignUpParams> {
  final AuthRepository repository;
  UserSignup(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(UserSignUpParams params) async {
    return await repository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;
  UserSignUpParams(
      {required this.password, required this.email, required this.name});
}
