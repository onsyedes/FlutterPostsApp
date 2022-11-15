import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_posts_bloc.dart';
class DeleteDialogWidget extends StatelessWidget {
  final int postId ;
  const DeleteDialogWidget({required this.postId , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddDeleteUpdatePostsBloc>(context).add(
              DeletePostEvent( postid: postId),
            );
          },
          child: Text("Yes"),
        ),
      ],
    );
  }
}
