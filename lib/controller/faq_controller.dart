import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../models/faq_model.dart';
import 'package:dio/dio.dart' as dio;

class FaqController extends GetxController {
  var isLoading = false.obs;
  var faqList = <FaqModel>[].obs;
  String url = 'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api';
  @override
  void onInit() {
    fetchFaqData();
    super.onInit();
  }

  Future<void> fetchFaqData() async {
    try {
      isLoading(true);
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var dio = Dio();
      var response = await dio.request(
        '$url/getFaq',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        faqList.clear();
        faqList.addAll(jsonData.map((item) => FaqModel(
            id: item['id'],
            question: item['question'],
            answer: item['answer'],
            createAt: item['create_at'])));
      } else {
        print('Error: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        print('Error: API endpoint not found (404)');
      } else {
        print('Error fetching FAQ data: ${e.message}');
      }
    } catch (e) {
      print('Error fetching FAQ data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> insertFaqData(FaqModel faqData) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var data = dio.FormData.fromMap({
        'question': faqData.question,
        'answer': faqData.answer,
      });

      var dioClient = dio.Dio();
      var response = await dioClient.request(
        '$url/insertFaq',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        await fetchFaqData(); // Refresh list after insert
      } else {
        print('Error: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      print('Error inserting FAQ data: ${e.message}');
    } catch (e) {
      print('Error inserting FAQ data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateFaqData(FaqModel faqData, int id) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var data = dio.FormData.fromMap({
        'question': faqData.question,
        'answer': faqData.answer,
      });

      var dioClient = dio.Dio();
      var response = await dioClient.request(
        '$url/updateFaq/$id',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        await fetchFaqData(); // Refresh list after update
      } else {
        print('Error: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      print('Error updating FAQ data: ${e.message}');
    } catch (e) {
      print('Error updating FAQ data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteFaqData(int id) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var dio = Dio();
      var response = await dio.request(
        '$url/deleteFaq/$id',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        await fetchFaqData(); // Refresh list after delete
      } else {
        print('Error: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      print('Error deleting FAQ data: ${e.message}');
    } catch (e) {
      print('Error deleting FAQ data: $e');
    } finally {
      isLoading(false);
    }
  }
}
