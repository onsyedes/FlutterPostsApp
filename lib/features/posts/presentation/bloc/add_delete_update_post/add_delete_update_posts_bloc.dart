import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts/core/error/failures.dart';
import 'package:posts/features/posts/domain/entities/post.dart';
import 'package:posts/features/posts/domain/useCases/add_post.dart';
import 'package:posts/features/posts/domain/useCases/delete_post.dart';
import 'package:posts/features/posts/domain/useCases/update_post.dart';
import 'package:posts/core/strings/failures.dart';
import 'package:posts/core/strings/success.dart';


part 'add_delete_update_posts_event.dart';
part 'add_delete_update_posts_state.dart';

class AddDeleteUpdatePostsBloc extends Bloc<AddDeleteUpdatePostsEvent, AddDeleteUpdatePostsState> {
    final DeletePostUseCase deletePostUseCase  ;
    final AddPostUseCase addPostUseCase;
    final UpdatePostUseCase updatePostUseCase ;

  AddDeleteUpdatePostsBloc(
      {required this.deletePostUseCase,required this.addPostUseCase,required this.updatePostUseCase}) : super(AddDeleteUpdatePostsInitial()) {

    on<AddDeleteUpdatePostsEvent>((event, emit) async {


      if(event is AddPostEvent){
        emit(LoadingAddDeleteUpdatePostsState());
        final response =await addPostUseCase(event.post) ;
        emit(_mapFailureOrUnitState(response,ADD_POST_SUCCESS_MESSAGE)) ;

      }else if(event is DeletePostEvent){
        emit(LoadingAddDeleteUpdatePostsState());
        final response =await deletePostUseCase(event.postid) ;
        emit(_mapFailureOrUnitState(response,DELETE_POST_SUCCESS_MESSAGE)) ;

      }else if(event is UpdatePostEvent){
        emit(LoadingAddDeleteUpdatePostsState());
        final response =await updatePostUseCase(event.post) ;
        emit(_mapFailureOrUnitState(response,UPDATE_POST_SUCCESS_MESSAGE)) ;
      }
    });
  }

  AddDeleteUpdatePostsState _mapFailureOrUnitState(Either<Failure, Unit> either ,String message){
    return either.fold(
            (failure) => ErrorAddDeleteUpdatePostsState (message:_mapFailuerToMessage(failure)),
            (_) => SuccessAddDeleteUpdatePostsState(message: message)  ) ;
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
