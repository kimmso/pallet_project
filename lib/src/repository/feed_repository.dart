import 'package:dio/dio.dart';

import 'package:pallet_project/src/model/feed.dart';
import 'package:pallet_project/src/utils/apiurl.dart';

class FeedRepository {
  final dio = Dio();

  Future<List<Feed>> feedApi() async {
    return dio.get(ApiUrls.feedUrl).then((response) {
      return List<Feed>.from(List<Map<String, dynamic>>.from(response.data)
          .map((json) => Feed.fromJson(json))
          .toList());
    });
  }

  Future<List<Feed>> secondApi(int pageNo) async {
    return dio.get("${ApiUrls.secondUrl}/$pageNo").then((response) =>
        List<Map<String, dynamic>>.from(response.data)
            .map((json) => Feed.fromJson(json))
            .toList());
  }

  // Future<void> putFeeds() async {
  //   try {
  //     dio.get(ApiUrls.feedUrl).then((response) {
  //       if (response.statusCode == 200) {
  //         print(122);
  //         final result = response.data;

  //         return result;
  //       } else {
  //         // exception
  //       }
  //       return Feed.fromJson(response.data);
  //     });
  //   } catch (e) {
  //     throw Exception();
  //   }
  // }

  // Future<void> putSeconds() async {
  //   try {
  //     dio.get(ApiUrls.feedUrl).then((response) {
  //       if (response.statusCode == 200) {
  //       } else {
  //         // exception
  //       }
  //       return Feed.fromJson(response.data);
  //     });
  //   } catch (e) {
  //     throw Exception();
  //   }
  // }
}
