import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';
import '../widgets/PostDetailWidget.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post ;
  const PostDetailsScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }
  AppBar _buildAppbar() {
    return AppBar(title: const Text('Post Details'),);
  }
  Widget _buildBody(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailWidget(post: post),
      ),
    );
  }
}
