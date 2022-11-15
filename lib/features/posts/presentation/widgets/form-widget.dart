import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_posts_bloc.dart';

import '../../../../core/shared_widgets/text-field-widget.dart';
import '../../domain/entities/post.dart';
class FormWidget extends StatefulWidget {

  final Post? post ;
  const FormWidget({required this.post , Key? key}) : super(key: key);


  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {

  final _formKey= GlobalKey<FormState>() ;
  final TextEditingController _titleFieldController=  TextEditingController();
  final TextEditingController _bodyFieldController=  TextEditingController();


  @override
  void initState() {
    super.initState();
    _titleFieldController.text= widget.post==null ? "" : widget.post!.title  ;
    _bodyFieldController.text= widget.post==null ? "" : widget.post!.body ;

  }
  void onSubmit(){
    final isValid = _formKey.currentState!.validate() ;
    if(isValid){
      final newPost = Post(
        // ignore: prefer_null_aware_operators
          id: widget.post==null? null : widget.post!.id,
          title: _titleFieldController.text,
          body: _bodyFieldController.text);

      if(widget.post==null){

        BlocProvider.of<AddDeleteUpdatePostsBloc>(context).add(AddPostEvent(post: newPost));
      }else{

        BlocProvider.of<AddDeleteUpdatePostsBloc>(context).add(UpdatePostEvent(post: newPost));

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key : _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFieldWidget( controller: _titleFieldController, name: 'Title', multiLines: false, ),
            TextFieldWidget( controller: _bodyFieldController, name: 'Body', multiLines: true, ),
          ElevatedButton.icon(
            onPressed: onSubmit,
          icon: widget.post==null ? const Icon(Icons.add) : const Icon(Icons.edit) ,
            label:  Text(widget.post==null ? 'Add' : 'Update'),

        )
          ],
        ),
      ),
    );

  }

}
