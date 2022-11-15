import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_posts_bloc.dart';

import '../../../../core/utils/snackbar-message.dart';
import '../../domain/entities/post.dart';
import 'delete-dialog-widget.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int? postId;
  const DeletePostBtnWidget({  required this.postId ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.redAccent,
          ),
        ),
        onPressed : ()=>showDeletePostDialog(context, postId),
        icon: const Icon(Icons.remove),
        label: const Text('Delete'),

      ),
    );
  }
  showDeletePostDialog(context, postId){
    showDialog(
        context: context,
        builder:(context) {
          return BlocConsumer<
              AddDeleteUpdatePostsBloc,
              AddDeleteUpdatePostsState>(
            listener: (context, state) {
              if (state is SuccessAddDeleteUpdatePostsState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
              }else if(state is ErrorAddDeleteUpdatePostsState){
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              return DeleteDialogWidget(postId: postId,);
            },
          );
        }

    );
  }
}
