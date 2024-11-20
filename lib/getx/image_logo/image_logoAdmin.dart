import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ImageLogoAdmin extends GetxController {
  @override
  void onInit() {
    imaegLogoAdmin();
    super.onInit();
  }

  var listLogoHomeMenu = [].obs;
  var listLogoSettingMenu = [].obs;
  var listLogoNoNumberMenu = [].obs;
  var listLogoOptionMenu = [].obs;
  Future<void> imaegLogoAdmin() async {
    var dio = Dio();
    var response = await dio.request(
      'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/images/fetch/IconAdmin',
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      listLogoOptionMenu.value = response.data['4'];
      //  listLogoHomeMenu.value = response.data['1'];
    }
  }
}
