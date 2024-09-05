import 'package:dio/dio.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pallet_project/src/model/myprofil.dart';
import 'package:pallet_project/src/utils/apiurl.dart';
import 'package:pallet_project/src/utils/dio_interceptor.dart';

class MyProfilRepository {
  final dio = Dio()..interceptors.add(BaseInterceptor());

  Future<MyProfil> myinfoApi() async {
    String? accessToken = GetStorage().read('accessToken');

    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    final response = await dio.get(ApiUrls.myinfoUrl);

    if (response.statusCode == 200) {
      print(response.statusCode);
      return MyProfil.fromJson(response.data);
    } else {
      throw Exception();
    }
  }

  Future<String> nicknameApi(Map<String, dynamic> json) async {
    String? accessToken = GetStorage().read('accessToken');

    dio.options.headers = {'Authorization': 'Bearer $accessToken'};

    final response = await dio.patch(ApiUrls.nicknameUrl, data: json);

    if (response.statusCode == 200) {
      final result = response.data;

      return result["name"];
    } else {
      Get.snackbar('실패', '실패');

      throw Exception();
    }
  }

  Future<void> passwordApi(Map<String, dynamic> json) async {
    try {
      String? accessToken = GetStorage().read('accessToken');

      dio.options.headers = {'Authorization': 'Bearer $accessToken'};

      final response = await dio.patch(ApiUrls.passwordUrl, data: json);

      if (response.statusCode == 200) {
      } else {
        Get.snackbar('실패', '실패');

        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }
  }
}
