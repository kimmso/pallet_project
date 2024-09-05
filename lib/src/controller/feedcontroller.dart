import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallet_project/src/model/feed.dart';
import 'package:pallet_project/src/repository/feed_repository.dart';

class FeedController extends GetxController {
  final Rx<List<Feed>> _feeds = Rx<List<Feed>>([]);

  final RxBool _isLoading = false.obs;

  late final ScrollController _scrollController;

  var profileImagePath = ''.obs;
  List<Feed> get feeds => _feeds.value;

  final FeedRepository repository;

  bool get isLoading => _isLoading.value;

  ScrollController get scrollController => _scrollController;

  FeedController({
    required this.repository,
  });

  @override
  void onInit() {
    super.onInit();
    _scrollController = ScrollController()..addListener(getNewFeedsPage);
    feedFetchData();
  }

  void feedFetchData() async {
    _isLoading(true);
    try {
      final result = await repository.feedApi();
      _feeds.value = result;
      _feeds.refresh();
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading(false);
    }
  }

  // void feedPutData() {
  //   repository.putFeeds();
  // }

  void getNewFeedsPage() async {
    if (_scrollController.offset !=
        _scrollController.position.maxScrollExtent) {
      return;
    }

    final lastPageNo = _feeds.value.last.postNo!;
    _isLoading(true);

    try {
      final result = await repository.secondApi(lastPageNo);
      if (result.isNotEmpty) {
        _feeds.update((feeds) {
          feeds!.addAll(result);
        });
      }
      // _feeds.value.addAll(result);
      // _feeds.refresh();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _isLoading(false);
    }
  }

  // Future<List<Feed>?> secondFetchData(int pageNo) async {
  //   try {
  //     List<Feed>? feedList = await repository.secondApi(pageNo);
  //     if (feedList!.isNotEmpty && feedList?.length == 18) {
  //       Future<List<Feed>?> finalList = checkNextData(feedList);
  //     }

  //     List<Feed>? finalFeedList = await checkNextData(feedList);

  //     return finalFeedList;
  //   } catch (e) {
  //     print("Error in secondFetchData: $e");
  //     return null; // 에러가 발생하면 null을 반환
  //   }
  // }

  // Future<List<Feed>?> checkNextData(List<Feed> feedList) async {
  //   // feedList의 마지막 순서의 post_no를 꺼내서 저장하기
  //   int pageNo = feedList.last.postNo!;
  //   // 해당 last_post_no 사용해서 페이징처리된 list 받아오기
  //   List<Feed>? addtionalList = await repository.secondApi(pageNo);

  //   // 모든 이미지가 포함된 최종 list
  //   feedList.addAll(addtionalList!);

  //   if (addtionalList!.isNotEmpty && addtionalList?.length == 18) {
  //     Future<List<Feed>?> lastList = checkNextData(addtionalList);

  //     feedList.addAll(lastList as Iterable<Feed>);
  //   }

  //   return feedList;
  // }
}
