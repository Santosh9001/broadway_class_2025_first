import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  dynamic getPosts() async {
    final dio = Dio();
    final response =
        await dio.get('https://jsonplaceholder.typicode.com/posts');
    return response;
  }

  Future<String> getPostsApiHttp() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    debugPrint(response.body);
    return response.body;
  }
}
