import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WordPressApiService extends GetxService {
static const String baseUrl = 'https://blog.bolenav.com/wp-json/wp/v2';

  // Generic GET request method
  Future<dynamic> get(String endpoint) async {
    try {
final response = await http.get(Uri.parse('$baseUrl/$endpoint')).timeout(const Duration(seconds:10));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception('Request timed out after 5 seconds');
      }
      throw Exception('Error: $e');
    }
  }



  // Common WordPress API endpoints
Future<List<dynamic>> getApiData(int endpoint, int page) async {
if(endpoint == 0 && page!=0){
  return await get('posts?page=$page');
}else if(endpoint == 0 && page==0){
return await get('categories');
}
  else{
return await get('posts?categories=$endpoint&page=$page');
}
  }



// https://blog.bolenav.com/wp-json/wp/v2/comments?post=163

Future<List<dynamic>> getComments(int postId,int Page) async {
return await get('comments?post=$postId&page=$Page');
}

Future<List<dynamic>> getSearch(String text) async {
return await get('posts?search=$text');
}

Future<List<dynamic>> getPopularApiData(int page) async {
return await get('posts?page=$page');
  }
}