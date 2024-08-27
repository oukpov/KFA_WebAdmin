import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/M_commune.dart';
import '../models/M_roadAndcommune.dart';
import '../models/Verbal_limited.dart';
import '../models/autoVerbal.dart';
import '../models/executive/Edit_Executive.dart';
import '../models/executive/buiding_executive.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';

class APIservice {
  // ទាញData from https://kfahrm.cc/Laravel/public/api/login

  Future<RegisterReponseModel> register(
      RegisterRequestModel requestModel) async {
    final response = await http.post(
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/register'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: requestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 422) {
      return RegisterReponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return RegisterReponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<RegisterReponseModel_update> update_user(
      RegisterRequestModel_update requestModel, int id_user) async {
    final response = await http.put(
        Uri.parse(
            'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/user/edit/${id_user.toString()}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: requestModel.toJson());

    return RegisterReponseModel_update.fromJson(json.decode(response.body));
  }

  Future<AutoVerbalReponseModel> saveAutoVerbal(
      AutoVerbalRequestModel requestModel) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/save'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      return AutoVerbalReponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return AutoVerbalReponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<AutoVerbalReponseModel> saveAutoVerbal_Update(
      AutoVerbalRequestModel_update requestModel, int id) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/save_new/${id}'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      return AutoVerbalReponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return AutoVerbalReponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<AutoVerbalReponseModel> saveVerbal(
      AutoVerbalRequestModel requestModel) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/verbals/save'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      return AutoVerbalReponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return AutoVerbalReponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
  // Future<dynamic> com_data() async {
  //   final response =
  //       await http.get(Uri.parse('http://127.0.0.1:8000/api/comparable/list'));

  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return jsonDecode(response.body);
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }
  // Future<List<ComparableData>> com_data() async {
  //   var response =
  //       await http.get(Uri.parse('http://127.0.0.1:8000/api/comparable/list'));
  //   return (json.decode(response.body)['data'] as List)
  //       .map((e) => ComparableData.fromJson(e))
  //       .toList();
  // }

  Future<M_CommuneReponeModel> SaveCommune(M_Commune requestModel) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new_commune'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      return M_CommuneReponeModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return M_CommuneReponeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<roadAndcommune_ReponeModel> RoadAndCommune(
      roadAndcommune requestModel) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new_rc'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 422) {
      return roadAndcommune_ReponeModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return roadAndcommune_ReponeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  Future<Verbal_limited_ReponeModel> Verballimited(
      Verbal_limited requestModel) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/limited_verbal'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 422) {
      return Verbal_limited_ReponeModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return Verbal_limited_ReponeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  ///Building Exective
  Future<Buidng_ReponseModel> saveExecutive(
      BuildingRequestModel requestModel) async {
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/new_add'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 422) {
      return Buidng_ReponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return Buidng_ReponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }

  ////Update Building
  Future<Executive_ReponseModel> building_Edit(
      ExecutiveRequestModel requestModel, id) async {
    print(id);
    final response = await http.post(
      Uri.parse(
          'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/update_executive/500'),
      headers: {
        "Accept": "application/json;charset=UTF-8",
        "Content-Type": "application/json"
      },
      body: json.encode(
        requestModel.toJson(),
      ),
    );
    // print(response.statusCode);
    // return Executive_ReponseModel.fromJson(json.decode(response.body));
    if (response.statusCode == 200 || response.statusCode == 422) {
      return Executive_ReponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 201 || response.statusCode == 401) {
      return Executive_ReponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
