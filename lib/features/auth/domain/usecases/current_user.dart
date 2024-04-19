import 'package:blog_app/core/failures/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/entities/user.dart';



class GetCurrentUser implements UseCase<UserEntity,NoParams>{
  final AuthRepository authRepository;
  GetCurrentUser(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params)async {
    return await authRepository.getUser();
  }

}

