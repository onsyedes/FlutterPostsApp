import 'package:dartz/dartz.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/core/error/failures.dart';
import 'package:posts/features/posts/data/data_sources/local_data_source.dart';
import 'package:posts/features/posts/data/data_sources/remote_data_source.dart';
import 'package:posts/features/posts/domain/entities/post.dart';
import 'package:posts/features/posts/domain/repositories/postsRepository.dart';

import '../../../../core/network/network_info.dart';
import '../models/post_model.dart';

class PostRepositoryImpl extends PostsRepository {
    final PostsLocalDataSource localDataSource;
    final PostsRemoteDataSource remoteDataSource;
    final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {required this.localDataSource,required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
   if(await networkInfo.isConnected){
     try{
        final remotePosts=await remoteDataSource.getAllPosts();
        await localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
     } on ServerException{
       return Left(ServerFailure());
     }
   }else{
     try{
       final localPosts=await localDataSource.getCachedPosts();
       return Right(localPosts);
     } on EmptyCacheException{
       return Left(EmptyCacheFailure());
     }
   }
  }


  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel=PostModel(id: post.id, title: post.title,body: post.body);
    return await _checkInternetConnection((){return remoteDataSource.addPost(postModel) ;}) ;

  }

  @override
  Future<Either<Failure, Unit>> deletePost(id) async {

    return await _checkInternetConnection((){return remoteDataSource.deletePost(id) ;}) ;

  }



  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel=PostModel(id: post.id, title: post.title,body: post.body);
    return await _checkInternetConnection((){return remoteDataSource.updatePost(postModel) ;}) ;
  }


    Future<Either<Failure, Unit>> _checkInternetConnection(Future<Unit> Function() DeleteOrUpdateOrAdd) async {
    if(await networkInfo.isConnected){
      try{
        await DeleteOrUpdateOrAdd();
        return Right(unit);
      } on ServerException{
        return Left(ServerFailure());
      }

    }else{
      return Left(OfflineFailure());
    }

  }
  
}