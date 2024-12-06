import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WordPressApiService extends GetxService {
static const String baseUrl = 'https://blog.bolenav.com/wp-json/wp/v2';

  // Generic GET request method
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }



  // Common WordPress API endpoints
Future<List<dynamic>> getApiData(int endpoint, int page) async {
return await get('posts?categories=$endpoint&page=$page');
  }

Future<List<dynamic>> getPopularApiData(int page) async {
return await get('posts?page=$page');
  }
}