import 'package:dartz/dartz.dart';
import 'package:posts/features/posts/domain/repositories/postsRepository.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class GetAllPostsUseCase{
  final PostsRepository postsRepository;

  GetAllPostsUseCase(this.postsRepository);
  Future<Either<Failure, List<Post>>> call() async {
    return await postsRepository.getAllPosts();
  }

}