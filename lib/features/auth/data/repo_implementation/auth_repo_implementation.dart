import 'package:blog_app/core/failures/exception.dart';
import 'package:blog_app/core/failures/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepoImplementation implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  AuthRepoImplementation(this.dataSource);
  @override
  Future<Either<Failure, UserModel>> signInWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await dataSource.signInWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async => await dataSource.signUpWithEmailPassword(
        name: name, email: email, password: password));
  }

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    // TODO: implement getUser
    try {
      final user = await dataSource.getCurrentUserData();
      if (user == null) {
        return Left(Failure(message: "User Not logged in"));
      } else {
        return Right(user);
      }
    } on ServerException catch (e) {
      return Left(Failure(message: e.message.toString()));
    }
  }
}

Future<Either<Failure, UserModel>> _getUser(
    Future<UserModel> Function() fn) async {
  try {
    final userId = await fn();
    return right(userId);
  } on sb.AuthException catch (e) {
    return Left(Failure(message: e.message.toString()));
  } on ServerException catch (e) {
    return Left(Failure(message: e.message.toString()));
  }
}
