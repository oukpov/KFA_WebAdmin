import 'package:dio/dio.dart';
import 'package:get/get.dart';

class BackgroupIcons extends GetxController {
  @override
  void onInit() {
    listIcon();
    super.onInit();
  }

  Map listOption = {}.obs;

  var listLenght = 0.obs;
  var isIcons = false.obs;

  Future<void> listIcon() async {
    try {
      isIcons.value = true;
      var dio = Dio();
      var response = await dio.request(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/merge/table/UI',
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        listOption = response.data;
        List list = listOption['option'];
        listLenght.value = list.length;
        print("listLenght : $listLenght");
      }
    } catch (e) {
      // print(e);
    } finally {
      isIcons.value = false;
    }
  }
}
