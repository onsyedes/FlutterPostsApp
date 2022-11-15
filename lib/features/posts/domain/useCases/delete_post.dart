import 'package:dartz/dartz.dart';
import 'package:posts/features/posts/domain/repositories/postsRepository.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';
class DeletePostUseCase{
  final PostsRepository postsRepository;

  DeletePostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(int postid ) async{
     return await postsRepository.deletePost(postid) ;
  }




}