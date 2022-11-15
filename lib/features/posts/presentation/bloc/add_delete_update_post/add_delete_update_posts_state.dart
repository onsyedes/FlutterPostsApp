part of 'add_delete_update_posts_bloc.dart';

abstract class AddDeleteUpdatePostsState extends Equatable {
  const AddDeleteUpdatePostsState();
  @override
  List<Object?> get props => [];
}

class AddDeleteUpdatePostsInitial extends AddDeleteUpdatePostsState {
  @override
  List<Object> get props => [];
}

class LoadingAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState{
}
class ErrorAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState{
  final String message;

  ErrorAddDeleteUpdatePostsState({required this.message});
  @override
  List<Object?> get props => [message];
}
class SuccessAddDeleteUpdatePostsState extends AddDeleteUpdatePostsState{
  final String message;

  SuccessAddDeleteUpdatePostsState({required this.message});
  @override
  List<Object?> get props => [message];
}

