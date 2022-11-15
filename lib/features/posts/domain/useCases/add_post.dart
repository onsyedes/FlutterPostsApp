import 'package:dartz/dartz.dart';
import 'package:posts/features/posts/domain/repositories/postsRepository.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class AddPostUseCase {
  final PostsRepository postsRepository;

  AddPostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(Post post ) async{
    return await postsRepository.addPost(post) ;
  }
}