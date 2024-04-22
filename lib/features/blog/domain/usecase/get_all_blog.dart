import 'package:blog_app/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failures/failure.dart';
import '../entity/blog.dart';
import '../repository/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
