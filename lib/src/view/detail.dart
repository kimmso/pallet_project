import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallet_project/src/controller/detailcontroller.dart';
import 'package:pallet_project/src/model/feeddetail.dart';

class DetailPage extends GetView<DetailController> {
  final int postNo;

  const DetailPage({Key? key, required this.postNo}) : super(key: key);

  void toggleLike() {
    if (controller.isLiked.value) {
      controller.minuslikefetchData();
    } else {
      controller.pluslikefetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<FeedDetail?> feedDetail =
        controller.detailfetchData(postNo); // 데이터 불러오기

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(() {
          final feedDetail = controller.feeddetails;
          String name = feedDetail?.name ?? '알 수 없음';
          return Text('$name 님의 게시글');
        }),
      ),
      body: Obx(() {
        final feedDetail = controller.feeddetails;
        if (feedDetail != null) {
          return _body(feedDetail);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  Widget _body(FeedDetail feedDetail) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                _likeButton(),
                _likeCount(),
              ],
            ),
            _image(feedDetail.photo_url),
            _date(feedDetail.create_date),
            const SizedBox(height: 20),
            _content(feedDetail.content),
          ],
        ),
      ),
    );
  }

  Widget _image(String? photoUrl) {
    return Container(
      color: Colors.grey,
      height: 400,
      width: double.infinity,
      child: photoUrl != null
          ? Image.network(photoUrl, fit: BoxFit.cover)
          : const Text('이미지 없음'),
    );
  }

  Widget _content(String? content) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: content != null
              ? Text(
                  content,
                  style: const TextStyle(fontSize: 16),
                )
              : const Text('내용 없음'),
        ),
      ),
    );
  }

  Widget _likeButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        bool isLiked = controller.isLiked.value;
        print('isLiked: $isLiked'); // 상태 확인
        return IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : null,
          ),
          onPressed: toggleLike, // 좋아요 토글 기능
        );
      }),
    );
  }

  Widget _likeCount() {
    return Obx(() {
      int likeCount = controller.like_count.value;
      return Text(
        '$likeCount',
        style: const TextStyle(fontSize: 16),
      );
    });
  }

  Widget _date(String? createDate) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          createDate != null ? createDate : '날짜 정보 없음',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
