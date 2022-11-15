import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
const CACHED_POSTS= "CACHED_POSTS";
abstract class PostsLocalDataSource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> listOfPosts);
}

class PostsLocalDataSourceImpl extends PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl({required this.sharedPreferences});


  @override
  Future<Unit> cachePosts(List<PostModel> listOfPosts) {
    List ListOfPostsToJson= listOfPosts.map<Map<String, dynamic>>((post) => post.toJson()).toList();

    sharedPreferences.setString(CACHED_POSTS,json.encode(ListOfPostsToJson) );
    return Future.value(unit) ;
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString("CACHED_POSTS") ;
    if(jsonString!=null){
       List decodedeData= json.decode(jsonString);
       List<PostModel> jsonToPostModel= decodedeData.map<PostModel>((jsonPostModel)=>PostModel.fromJson(jsonPostModel)).toList();
        return Future.value(jsonToPostModel);

    }else{
      throw EmptyCacheException();
    }
  }
  
}