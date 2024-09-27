import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/verbal_model.dart';

class VerbalController {
  static const String apiUrl =
      'https://www.oneclickonedollar.com/Demo_BackOneClickOnedollar/public/api/reportverbal';

  Future<List<verbal_model>> fetchVerbalReports() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => verbal_model.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load verbal reports: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching verbal reports: $e');
    }
  }

  Future<verbal_model?> fetchVerbalReportById(int id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$id'));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        return verbal_model.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('Failed to load verbal report: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching verbal report: $e');
    }
  }
}
