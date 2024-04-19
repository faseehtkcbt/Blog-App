import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/entities/user.dart';
import '../repositories/auth_repository.dart';

class UserLogin implements UseCase<UserEntity, UserSignInParams> {
  final AuthRepository repository;
  UserLogin(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(UserSignInParams params) async {
    return await repository.signInWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;
  UserSignInParams({
    required this.password,
    required this.email,
  });
}
