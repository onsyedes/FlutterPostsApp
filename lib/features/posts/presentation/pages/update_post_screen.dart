import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_posts_bloc.dart';

import '../../../../core/utils/snackbar-message.dart';
import '../../domain/entities/post.dart';
import '../widgets/add-update-widget.dart';
import '../widgets/form-widget.dart';

class UpdatePostScreen extends StatelessWidget {
  final Post post;
  const UpdatePostScreen({ required this.post , Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: AddUpdateWidget(post : post),
    );

  }

  AppBar  _buildAppbar(){
    return AppBar(title: const Text('Update Post')) ;
  }


}
