import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../../../../core/utils/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> getUser();
}
