import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/features/posts/presentation/bloc/posts/posts_bloc.dart';

import '../../../../core/shared_widgets/ErrorMesageDisplayWidget.dart';
import '../../../../core/shared_widgets/LoadingWidget.dart';
import '../widgets/PostsListWidget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body : _buildBody(),
      floatingActionButton: _buildFloatingActionBtn(context),
    );
  }

 AppBar _buildAppBar() => AppBar(title: const Text('Posts')) ;
  Widget _buildBody(){
    return Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<PostsBloc,PostsState>(
          builder : (context,state){
            if (state is LoadingPostsState){
              return const LoadingWidget();
            }else if(state is LoadedPostsState){
              return RefreshIndicator(
                onRefresh: ()=>_onRefresh(context),
                child: PostsListWidget(
                  posts : state.posts
                ),
              );
            }else if(state is ErrorPostsState){
              return ErrorMesageDisplayWidget(
                message : state.message
              );
            }
            return const LoadingWidget();
          }
        ),
    );
  }
}

Widget  _buildFloatingActionBtn (BuildContext context){
  return FloatingActionButton(
    onPressed: () {
        Navigator.of(context).pushNamed('/addpost') ;
    },
    child: const Icon(Icons.add),
  );
}

_onRefresh (BuildContext context) async {
  context.read<PostsBloc>().add(RefreshPostsEvent());
}