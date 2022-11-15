
import 'package:flutter/material.dart';
import 'package:posts/features/posts/presentation/widgets/EditPostBtnWidget.dart';

import '../../domain/entities/post.dart';
import 'DeletePostBtnWidget.dart';
class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
      child : Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 50),
          Text(
            post.body,
            style: const TextStyle(
              fontSize: 16,
            ),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              EditPostBtnWidget(post : post),
              DeletePostBtnWidget(postId : post.id)
            ],

          )
        ],
      )

    );
  }
}
