import 'package:dio/dio.dart';

import 'package:get_storage/get_storage.dart';
import 'package:pallet_project/src/model/feed.dart';
import 'package:pallet_project/src/utils/apiurl.dart';

class FeedRepository {
  final dio = Dio();

  Future<List<Feed>?> feedApi() async {
    try {
      final response = await dio.get(ApiUrls.feedUrl);

      if (response.statusCode == 200) {
        List<Feed> feeds = [];
        for (var data in response.data) {
          final feed = Feed.fromJson(data);
          feeds.add(feed);
        }
        return feeds;
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> putFeeds() async {
    try {
      dio.get(ApiUrls.feedUrl).then((response) {
        if (response.statusCode == 200) {
        } else {
          // exception
        }
        return Feed.fromJson(response.data);
      });
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<Feed>?> secondApi() async {
    try {
      String? post_no = GetStorage().read('post_no');

      if (post_no != null) {
        String secondUrl = "${ApiUrls.secondUrl}$post_no";

        final response = await dio.get(secondUrl);

        if (response.statusCode == 200) {
          List<Feed> feeds = [];
          for (var data in response.data) {
            final feed = Feed.fromJson(data);
            feeds.add(feed);
          }
          return feeds;
        }
      }
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> putSeconds() async {
    try {
      dio.get(ApiUrls.feedUrl).then((response) {
        if (response.statusCode == 200) {
        } else {
          // exception
        }
        return Feed.fromJson(response.data);
      });
    } catch (e) {
      throw Exception();
    }
  }
}
