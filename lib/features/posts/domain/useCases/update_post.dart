import 'package:dartz/dartz.dart';
import 'package:posts/features/posts/domain/repositories/postsRepository.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class UpdatePostUseCase {
  final PostsRepository postsRepository;

  UpdatePostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(Post post ) async{
    return await postsRepository.updatePost(post) ;
  }
}