import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts/core/error/exceptions.dart';
import 'package:posts/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;
abstract class PostsRemoteDataSource {
  Future<List<PostModel>>getAllPosts();
  Future<Unit> deletePost(int postid);
  Future<Unit> addPost(PostModel post);
  Future<Unit> updatePost(PostModel post);
}
const BASE_URL="https://jsonplaceholder.typicode.com";
class PostsRemoteDataSourceImpl extends PostsRemoteDataSource{
  final http.Client client ;

  PostsRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async{
    final response= await client.get(Uri.parse(BASE_URL+'/posts/'),
      headers : {"Content-Type": "application/json"})  ;
    if(response.statusCode==200){
        List decodedData= json.decode(response.body) as List ;
        List<PostModel> postModelList = decodedData.map<PostModel>((jsonPostModel)=> PostModel.fromJson(jsonPostModel)).toList();
      return postModelList;
    }else{
      throw ServerException();
    }
  }
  @override
  Future<Unit> addPost(PostModel post) async{
    final body ={
      'title': post.body,
      'body' : post.body
    };

     final response= await client.post(Uri.parse(BASE_URL+"/posts/") , body : body);
      return _CheckServerResponse(response,201);


  }

  @override
  Future<Unit> deletePost(int postid) async{
    final response= await client.delete(Uri.parse(BASE_URL+"/posts/"+ postid.toString()) ,   headers : {"Content-Type": "application/json"});
    return _CheckServerResponse(response, 200);
  }


  @override
  Future<Unit> updatePost(PostModel post) async {
    final postid= post.id.toString() ;
    final response= await client.patch(Uri.parse(BASE_URL+"/posts/"+ postid.toString()) ,   headers : {"Content-Type": "application/json"});
    return _CheckServerResponse(response, 200);

  }
  Future<Unit> _CheckServerResponse (response,validResponse) {
    if(response.statusCode==validResponse){
      return Future.value(unit) ;

    }else{
      throw ServerException();
    }
  }
}
