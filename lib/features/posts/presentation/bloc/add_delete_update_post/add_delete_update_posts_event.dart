part of 'add_delete_update_posts_bloc.dart';

abstract class AddDeleteUpdatePostsEvent extends Equatable {
  const AddDeleteUpdatePostsEvent();

  @override
  List<Object> get props => [] ;
}

class AddPostEvent extends AddDeleteUpdatePostsEvent{
  final Post post;

  AddPostEvent({required this.post});
  @override
  List<Object> get props => [post] ;

}
class DeletePostEvent extends AddDeleteUpdatePostsEvent{
  final int postid ;

  DeletePostEvent({required this.postid});


  @override
  List<Object> get props => [postid] ;

}
class UpdatePostEvent extends AddDeleteUpdatePostsEvent{
  final Post post;

  UpdatePostEvent({required this.post});
  @override
  List<Object> get props => [post] ;

}