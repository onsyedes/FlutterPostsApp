import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/core/error/failures.dart';
import 'package:posts/features/posts/domain/entities/post.dart';
import 'package:posts/core/strings/failures.dart';

import '../../../domain/useCases/get_all_posts.dart';
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if(event is GetAllPostsEvent || event is RefreshPostsEvent){
         emit(LoadingPostsState());
         final failureOrPosts =  await getAllPostsUseCase() ;
         emit(_mapFailureOrPostsState(failureOrPosts)) ;
      }
    });
  }



  PostsState _mapFailureOrPostsState (Either<Failure, List<Post>> either){
   return either.fold(
            (failure) => ErrorPostsState(message : _mapFailuerToMessage(failure)),
            (posts) => LoadedPostsState(posts: posts)
    );
  }
   String _mapFailuerToMessage(Failure failure){
    switch(failure.runtimeType) {
      case ServerFailure :
        return SEREVER_FAILURE_MESSAGE;
      case EmptyCacheFailure  :
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure :
        return OFFLINE_FAILURE_MESSAGE ;
      default :
        return 'Unexpected Error , please try again later.';
    }
  }


}
