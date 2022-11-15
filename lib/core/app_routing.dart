import 'package:flutter/material.dart';
import 'package:posts/features/posts/domain/entities/post.dart';
import 'package:posts/features/posts/presentation/pages/delete_post_screen.dart';
import 'package:posts/features/posts/presentation/pages/post_details_screen.dart';

import '../features/posts/presentation/pages/add-post-screen.dart';
import '../features/posts/presentation/pages/posts_screen.dart';
import '../features/posts/presentation/pages/update_post_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings){
    final args=routeSettings.arguments;
    switch(routeSettings.name){
      case '/':
        return MaterialPageRoute(builder: (context)=> const PostsScreen()) ;
        case '/postdetails':
        return MaterialPageRoute(builder: (context)=>  PostDetailsScreen(post: args as Post)) ;
            case '/updatepost':
            return MaterialPageRoute(builder: (context)=>  UpdatePostScreen(post : args as Post)) ;
            case '/addpost':
            return MaterialPageRoute(builder: (context)=>  const AddPostScreen()) ;
      default :
        return _errorRoute() ;
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (context){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error '),
          centerTitle: true,
        ),
        body: const Center(
          child :   Text('Page not found ! ')
        ),
      );
    });
  }
}