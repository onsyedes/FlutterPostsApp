import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared_widgets/LoadingWidget.dart';
import '../../../../core/utils/snackbar-message.dart';
import '../../domain/entities/post.dart';
import '../bloc/add_delete_update_post/add_delete_update_posts_bloc.dart';
import 'form-widget.dart';

class AddUpdateWidget extends StatelessWidget {
  final Post? post ;
  const AddUpdateWidget({required this.post,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<AddDeleteUpdatePostsBloc,AddDeleteUpdatePostsState>(
              listener: (context,state){
                if( state is SuccessAddDeleteUpdatePostsState){
                  SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false) ;
                }else if(state is ErrorAddDeleteUpdatePostsState){
                  SnackBarMessage().showErrorSnackBar(message: state.message, context: context) ;
                  // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false) ;
                }
              },
              builder :(context,state) {
                if (state is LoadingAddDeleteUpdatePostsState) {
                  return const LoadingWidget();
                }
                return FormWidget(post: post);
              }
          ),
        ),
      );

  }

}
