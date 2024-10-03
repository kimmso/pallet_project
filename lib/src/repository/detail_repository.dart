import 'package:dio/dio.dart';

import 'package:get_storage/get_storage.dart';
import 'package:pallet_project/src/model/feeddetail.dart';
import 'package:pallet_project/src/utils/apiurl.dart';

class DetailRepository {
  final dio = Dio();
  Future<FeedDetail?> detailApi(int postNo) async {
    try {
      dio.options.contentType = 'application/json';

      String? accessToken = GetStorage().read('accessToken');

      dio.options.headers = {'Authorization': 'Bearer $accessToken'};

      String detailUrl = "${ApiUrls.detailUrl}/${postNo}";

      final response = await dio.get(detailUrl);

      if (response.statusCode == 200) {
        print("여기");
        print(response.data);
        return FeedDetail.fromJson(response.data);
      } else {
        print("글 불러오기 실패");

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
    return null;
  }

  Future<bool> likeApi(int postNo) async {
    try {
      dio.options.contentType = 'application/json';
      String? accessToken = GetStorage().read('accessToken');
      if (accessToken == null) {
        throw Exception('Access token is missing');
      }

      dio.options.headers = {'Authorization': 'Bearer $accessToken'};
      String likeUrl = "${ApiUrls.likeUrl}/$postNo";

      final response = await dio.post(likeUrl);

      if (response.statusCode == 201) {
        return true; // 성공 시 true 반환
      } else {
        print("Failed to like the post");
        print("Response data: ${response.data}");
        return false; // 실패 시 false 반환
      }
    } catch (error) {
      _handleError(error);
      return false; // 예외 발생 시 false 반환
    }
  }

  // Method to unlike a post
  Future<bool> minuslikeApi(int postNo) async {
    try {
      dio.options.contentType = 'application/json';

      String? accessToken = GetStorage().read('accessToken');
      if (accessToken == null) {
        throw Exception('Access token is missing');
      }

      dio.options.headers = {'Authorization': 'Bearer $accessToken'};

      String likeUrl = "${ApiUrls.likeUrl}/$postNo";
      print('DELETE URL: $likeUrl');

      final response = await dio.delete(likeUrl);
      print('Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Failed to unlike the post");
        print("Response data: ${response.data}");
        return false;
      }
    } catch (error) {
      _handleError(error);
      return false;
    }
  }

  // Centralized error handling
  void _handleError(dynamic error) {
    if (error is DioError) {
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
