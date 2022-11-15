import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';

class EditPostBtnWidget extends StatelessWidget {
  final Post post ;
  const EditPostBtnWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50.0),
      child: ElevatedButton.icon(
          onPressed : (){
            Navigator.of(context).pushNamed('/updatepost', arguments: post);
          },
        icon: const Icon(Icons.edit),
      label: const Text('Edit'),

      ),
    );
  }
}
