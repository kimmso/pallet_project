import 'package:dio/dio.dart';

import 'package:get_storage/get_storage.dart';
import 'package:pallet_project/src/model/postlist.dart';
import 'package:pallet_project/src/utils/apiurl.dart';

class PostListRepository {
  final dio = Dio();

  Future<List<PostList>?> postlistApi(String targetTime) async {
    try {
      String postlistUrl = "${ApiUrls.mypostUrl}/$targetTime";

      String? accessToken = GetStorage().read('accessToken');
      // dio.options.contentType = 'application/json';

      dio.options.headers = {'Authorization': 'Bearer $accessToken'};
      final response = await dio.get(postlistUrl);

      if (response.statusCode == 200) {
        List<PostList> postlists = [];

        if (response.data is List) {
          if (response.data.isNotEmpty) {
            for (var data in response.data) {
              final postlist = PostList.fromJson(data);

              postlists.add(postlist);
            }
          } else {
            print('response.data is empty');
          }
        } else {
          print('response.data is not a list');
        }

        return postlists;
      } else {
        print(3);
        throw Exception();
      }
    } catch (e) {
      print('Error occurred while fetching post list: $e'); // 에러 메시지 출력
      throw Exception('Failed to fetch post list: $e');
    }
  }

  Future<void> putPostLists(Map<String, dynamic> json) async {
    try {
      dio.put(ApiUrls.mypostUrl, data: json).then((response) {
        //print(response.statusCode);
        if (response.statusCode == 200) {
        } else {
          // exception
        }
        return PostList.fromJson(response.data);
      });
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> deleteApi(int post_no) async {
    try {
      String? accessToken = GetStorage().read('accessToken');

      dio.options.headers = {'Authorization': 'Bearer $accessToken'};

      String deleteUrl = "${ApiUrls.postUrl}/${post_no}";

      final response = await dio.delete(deleteUrl);
      print(deleteUrl);

      if (response.statusCode == 200) {
      } else if (response.statusCode == 400) {
        final errorMessage = response.data['error'];
        print("삭제하기 실패: $errorMessage");
      } else {
        throw Exception("삭제하기 오류");
      }
    } catch (e) {
      print("Error in deleteApi: $e");
      throw Exception("삭제하기 중 오류 발생");
    }
  }

  void likeApi(int postNo) async {
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
      } else {
        print("Failed to like the post");
        print("Response data: ${response.data}");

        // 예외처리 필요
      }
    } catch (error) {
      _handleError(error);
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
