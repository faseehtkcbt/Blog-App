import 'package:blog_app/core/failures/failure.dart';
import 'package:dartz/dartz.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
