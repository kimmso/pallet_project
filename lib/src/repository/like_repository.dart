// import 'package:dio/dio.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:pallet_project/src/utils/apiurl.dart';

// class LikeRepository {
//   final Dio dio = Dio();

//   // Method to like a post
//   Future<bool> likeApi(int postNo) async {
//     try {
//       dio.options.contentType = 'application/json';

//       String? accessToken = GetStorage().read('accessToken');
//       if (accessToken == null) {
//         throw Exception('Access token is missing');
//       }

//       dio.options.headers = {'Authorization': 'Bearer $accessToken'};

//       String likeUrl = "${ApiUrls.likeUrl}/$postNo";

//       final response = await dio.post(likeUrl);

//       if (response.statusCode == 201) {
//         return true;
//       } else {
//         print("Failed to like the post");
//         print("Response data: ${response.data}");
//         return false;
//       }
//     } catch (error) {
//       _handleError(error);
//       return false;
//     }
//   }

//   // Method to unlike a post
//   Future<bool> minuslikeApi(int postNo) async {
//     try {
//       dio.options.contentType = 'application/json';

//       String? accessToken = GetStorage().read('accessToken');
//       if (accessToken == null) {
//         throw Exception('Access token is missing');
//       }

//       dio.options.headers = {'Authorization': 'Bearer $accessToken'};

//       String likeUrl = "${ApiUrls.likeUrl}/$postNo";
//       print('DELETE URL: $likeUrl');

//       final response = await dio.delete(likeUrl);
//       print('Status code: ${response.statusCode}');

//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         print("Failed to unlike the post");
//         print("Response data: ${response.data}");
//         return false;
//       }
//     } catch (error) {
//       _handleError(error);
//       return false;
//     }
//   }

//   // Centralized error handling
//   void _handleError(dynamic error) {
//     if (error is DioError) {
//       if (error.response != null) {
//         print('Response error: ${error.response}');
//       } else {
//         print('Connection error: $error');
//       }
//     } else {
//       print('Non-DioError: $error');
//     }
//   }
// }
