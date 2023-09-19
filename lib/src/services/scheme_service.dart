import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

const String baseUrl = 'https://vikaspedia.in/schemesall/schemes-for-farmers';

class HttpService {
  static Future<String?> get() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      log('Httpervice $e');
    }
    return null;
  }
}
