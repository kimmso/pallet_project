import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';

import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pallet_project/src/model/post.dart';
import 'package:pallet_project/src/utils/apiurl.dart';

class PostRepository {
  final Dio dio = Dio(); // Dio 인스턴스 초기화 및 설정

  Future<Post?> writeApi(XFile? file) async {
    try {
      if (file == null) {}

      String? accessToken = GetStorage().read('accessToken');

      dio.options.headers = {'Authorization': 'Bearer $accessToken'};

      dio.options.contentType = 'multipart/form-data';

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file!.path,
            filename: generateRandomFileName())
      });

      final response = await dio.post(ApiUrls.writeUrl, data: formData);

      if (response.statusCode == 201) {
        return Post.fromJson(response.data);
      } else if (response.statusCode == 400) {
        final errorMessage = response.data['error'];
        print("글쓰기 실패: $errorMessage");
        return null;
      } else {
        throw Exception("글쓰기 오류");
      }
    } catch (e) {
      print("Error in loginApi: $e");
      throw Exception("글쓰기 중 오류 발생");
    }
  }

  Future<void> putPosts(Map<String, dynamic> json) async {
    try {
      dio.put(ApiUrls.writeUrl, data: json).then((response) {
        if (response.statusCode == 201) {
        } else {
          // exception
        }
        return Post.fromJson(response.data);
      });
    } catch (e) {
      throw Exception();
    }
  }

  Future<Post?> contentApi(Map<String, dynamic> json) async {
    try {
      dio.options.contentType = 'application/json';
      String? accessToken = GetStorage().read('accessToken');
      dio.options.headers = {'Authorization': 'Bearer $accessToken'};

      final response = await dio.post(ApiUrls.postUrl, data: jsonEncode(json));
      print(response.statusCode);

      if (response.statusCode == 201) {
      } else {
        print("글쓰기 실패");
        print(response.data);
        return null;
      }
    } catch (error) {
      // DioError인 경우
      if (error is DioError) {
        // 에러 타입에 따라 처리
        if (error.response != null) {
          print('Response error: ${error.response}');
        } else {
          print('Connection error: $error');
        }
      } else {
        print('Non-DioError: $error');
      }
    }
  }

  Future<void> putContents(Map<String, dynamic> json) async {
    try {
      dio.options.contentType = 'application/json'; // 수정: 멀티파트 형식을 JSON으로 변경

      dio.put(ApiUrls.postUrl, data: json).then((response) {
        print(response.statusCode);
        if (response.statusCode == 201) {
          return Post.fromJson(response.data);
        } else {
          // exception
        }
        return Post.fromJson(response.data);
      });
    } catch (e) {
      throw Exception();
    }
  }

  String generateRandomFileName() {
    // 6자리의 난수를 생성하여 확장자를 붙여서 반환
    return '${Random().nextInt(900000) + 100000}.jpg';
  }

  Future<Post?> changeimageApi(XFile? file, int postNo) async {
    try {
      String? accessToken = GetStorage().read('accessToken');

      dio.options.headers = {'Authorization': 'Bearer $accessToken'};

      dio.options.contentType = 'multipart/form-data';

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file!.path,
            filename: generateRandomFileName())
      });
      String changeimageUrl = "${ApiUrls.writeUrl}/${postNo}";
      print("진짜 1");
      print(postNo);
      final response = await dio.patch(changeimageUrl, data: formData);
      print("진짜 2");

      if (response.statusCode == 201) {
        print(response.statusCode);
        return Post.fromJson(response.data);
      } else if (response.statusCode == 400) {
        final errorMessage = response.data['error'];
        print("수정하기 실패: $errorMessage");
        return null;
      } else {
        throw Exception("수정하기 오류");
      }
    } catch (e) {
      print("Error in loginApi: $e");
      throw Exception("수정하기 중 오류 발생");
    }
  }

  Future<Post?> changecontentApi(Map<String, dynamic> json, int post_no) async {
    try {
      dio.options.contentType = 'application/json';
      String? accessToken = GetStorage().read('accessToken');
      dio.options.headers = {'Authorization': 'Bearer $accessToken'};
      String changecontentUrl = "${ApiUrls.postUrl}/${post_no}";
      final response =
          await dio.patch(changecontentUrl, data: jsonEncode(json));
      print(response.statusCode);

      if (response.statusCode == 200) {
      } else {
        print("글쓰기 실패");
        print(response.data);
        return null;
      }
    } catch (error) {
      // DioError인 경우
      if (error is DioError) {
        // 에러 타입에 따라 처리
        if (error.response != null) {
          print('Response error: ${error.response}');
        } else {
          print('Connection error: $error');
        }
      } else {
        print('Non-DioError: $error');
      }
    }
  }
}
