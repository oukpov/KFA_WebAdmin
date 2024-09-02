// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/LandBuilding/landbuilding_Model.dart';
import '../../models/verbalModel/verbal_model.dart';
import '../agent_credit/credit_agent.dart';

class VerbalAdd extends GetxController {
  var verbalID = "".obs;
  var isverbal = true.obs;
  Timer? _timer;
  var countwaiting = 0.obs;
  var iswaiting = false.obs;
  var isdeleteDone = false.obs;
  var isdeletelandDone = false.obs;
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> timewating() async {
    countwaiting.value = 0;
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) async {
      countwaiting++;
      if (countwaiting.value >= 3) {
        iswaiting.value = false;
        _timer?.cancel();
      }
    });
  }

  Future verbalIdRadom(id) async {
    verbalID.value =
        "$id${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(100)}${Random().nextInt(1000)}";
  }

  CreditAgent creditAgent = CreditAgent();
  Future saveAuto(Data datamodel, String verbalIDs, List listland,
      String base64string, int idUser, int credit) async {
    print(
        "verbalID : $verbalIDs\ndatamodel.verbalUser : ${datamodel.verbalUser}");
    try {
      isverbal.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "title_number": datamodel.titleNumber,
        "borey": datamodel.borey,
        "road": datamodel.road,
        "verbal_property_id": datamodel.propertyTypeId,
        "verbal_bank_id": datamodel.verbalBankId,
        "verbal_bank_branch_id": datamodel.verbalBankBranchId,
        "verbal_bank_contact": datamodel.verbalBankContact,
        "verbal_owner": datamodel.verbalOwner,
        "verbal_contact": datamodel.verbalContact,
        "verbal_bank_officer": datamodel.verbalBankOfficer,
        "verbal_address": datamodel.verbalAddress,
        "verbal_approve_id": datamodel.approveId,
        "VerifyAgent": datamodel.verifyAgent,
        "latlong_log": datamodel.latlongLog,
        "latlong_la": datamodel.latlongLa,
        "verbalImage": base64string,
        "verbal_user": datamodel.verbalUser,
        "verbal_option": datamodel.verbalOption,
        "protectID": verbalIDs,
        "VerbalType": listland
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/add/verbal',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print("Post Successfuly");
        Get.snackbar(
          "Done",
          "Done successfuly",
          colorText: Colors.black,
          padding:
              const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
          borderColor: const Color.fromARGB(255, 48, 47, 47),
          borderWidth: 1.0,
          borderRadius: 5,
          backgroundColor: const Color.fromARGB(255, 235, 242, 246),
          icon: const Icon(Icons.add_alert),
        );
        datamodel.clear();
        // ot tern +
        creditAgent.creditAgentMore(credit, idUser);
        // print("credit => $credit");
      } else {
        // print("No post Successfuly");
      }
    } catch (e) {
      // print('Error occurred: $e');
    } finally {
      isverbal.value = false;
      verbalID.value =
          "$idUser${Random().nextInt(10)}${Random().nextInt(10)}${Random().nextInt(100)}${Random().nextInt(1000)}";
    }
  }

  Future<void> updatelandbuilding(LandbuildingModels modelland) async {
    print(
        'verbalLandID : ${modelland.verbalLandId} | verbalLandType : ${modelland.verbalLandArea}');
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "verbal_land_type": modelland.verbalLandType,
      "verbal_land_des": modelland.verbalLandDes,
      "verbal_land_area": modelland.verbalLandArea,
      "verbal_land_minsqm": modelland.verbalLandMinsqm,
      "verbal_land_maxsqm": modelland.verbalLandMaxsqm,
      "verbal_land_minvalue": modelland.verbalLandMinvalue,
      "verbal_land_maxvalue": modelland.verbalLandMaxvalue,
      "address": modelland.address
    });
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updatelandbulding/${modelland.verbalLandId}',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print("Update land Successfuly");
      Get.snackbar(
        "Done",
        "Update successfuly",
        colorText: Colors.black,
        padding:
            const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
        borderColor: const Color.fromARGB(255, 48, 47, 47),
        borderWidth: 1.0,
        borderRadius: 5,
        backgroundColor: const Color.fromARGB(255, 235, 242, 246),
        icon: const Icon(Icons.add_alert),
      );
    } else {
      print(response.statusMessage);
    }
  }

  Future<void> updateAuto(var listData, int verbalIDs, List listland,
      String base64string, List listlandbuilding) async {
    print('verbalIDs : $verbalIDs\nlistland : $listland');
    try {
      isverbal.value = true;
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({
        "title_number": listData['title_number'],
        "borey": listData['borey'],
        "road": listData['road'],
        "verbal_property_id": listData['verbal_property_id'],
        "verbal_bank_id": listData['verbal_bank_id'],
        "verbal_bank_branch_id": listData['verbal_bank_branch_id'],
        "verbal_bank_contact": listData['verbal_bank_contact'],
        "verbal_owner": listData['verbal_owner'],
        "verbal_contact": listData['verbal_contact'],
        "verbal_bank_officer": listData['verbal_bank_officer'],
        "verbal_address": listData['verbal_address'],
        "verbal_approve_id": listData['verbal_approve_id'],
        "latlong_log": listData['latlong_log'],
        "latlong_la": listData['latlong_la'],
        if (base64string != "No") "verbalImage": base64string,
        "verbal_user": listData['verbal_user'],
        "verbal_option": listData['verbal_option'],
        "VerbalType": listland
      });
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/updateAuto/$verbalIDs',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print("Update Successfuly");
        Get.snackbar(
          "Done!",
          "Update Successfuly",
          colorText: Colors.black,
          padding:
              const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
          borderColor: const Color.fromARGB(255, 48, 47, 47),
          borderWidth: 1.0,
          borderRadius: 5,
          backgroundColor: const Color.fromARGB(255, 235, 242, 246),
          icon: const Icon(Icons.add_alert),
        );
        deletelandbuilding(listlandbuilding);
      } else {
        print("No post Successfuly");
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isverbal.value = false;
    }
  }

  Future<void> deleteAuto(title, id) async {
    try {
      print('title : $title | id : $id');
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({title: id});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/deleteAuto',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "Done!",
          "Delete success",
          colorText: Colors.black,
          padding:
              const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
          borderColor: const Color.fromARGB(255, 48, 47, 47),
          borderWidth: 1.0,
          borderRadius: 5,
          backgroundColor: const Color.fromARGB(255, 235, 242, 246),
          icon: const Icon(Icons.add_alert),
        );
        // print(json.encode(response.data));
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
// print(e);
    } finally {
      isdeleteDone.value = false;
    }
  }

  Future<void> deletelandbuilding(List listlandbuiding) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var data = json.encode({"landbuilding": listlandbuiding});
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/deleted/landbuilding',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        // Get.snackbar(
        //   "Done!",
        //   "Delete success",
        //   colorText: Colors.black,
        //   padding:
        //       const EdgeInsets.only(right: 50, left: 50, top: 20, bottom: 20),
        //   borderColor: const Color.fromARGB(255, 48, 47, 47),
        //   borderWidth: 1.0,
        //   borderRadius: 5,
        //   backgroundColor: const Color.fromARGB(255, 235, 242, 246),
        //   icon: const Icon(Icons.add_alert),
        // );
        print('Deleted succesfuly');
      } else {
        // print(response.statusMessage);
      }
    } catch (e) {
// print(e);
    } finally {
      isdeletelandDone.value = false;
    }
  }
}
