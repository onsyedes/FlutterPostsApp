import 'package:flutter/material.dart';

import '../widgets/add-update-widget.dart';
class AddPostScreen extends StatelessWidget {

  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: const AddUpdateWidget(post : null),
    );
  }
  AppBar  _buildAppbar(){
    return AppBar(title: const Text('Add Post')) ;
  }
}
