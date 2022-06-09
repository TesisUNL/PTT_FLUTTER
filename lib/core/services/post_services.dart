import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:ptt_rtmb/core/models/post_model.dart';
import 'dart:io';

Uri url = 'http://localhost:3000/auth' as Uri;

Future<List<Post>> getAllPosts() async {
  final response = await http.get(url);
  print(response);
  return allPostsFromJson(response.body);
}

Future<Post> getPost() async {
  Uri path = '$url/register' as Uri;
  final response = await http.get(path);
  return postFromJson(response.body);
}

Future<http.Response> createPost(Post post) async {
  final response = await http.post(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: ''
      },
      body: postToJson(post));
  return response;
}

//Future<Post> createPost(Post post) async{
//  final response = await http.post('$url',
//      headers: {
//        HttpHeaders.contentTypeHeader: 'application/json'
//      },
//      body: postToJson(post)
//  );
//
//  return postFromJson(response.body);
//}