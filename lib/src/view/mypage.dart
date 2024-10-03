import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallet_project/src/app.dart';
import 'package:pallet_project/src/controller/detailcontroller.dart';
import 'package:pallet_project/src/controller/postlistcontroller.dart';
import 'package:pallet_project/src/model/postlist.dart';
import 'package:pallet_project/src/view/update.dart';

class MyPage extends StatefulWidget {
  final DateTime selectedDate;

  MyPage({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final DetailController detailController = Get.find<DetailController>();
  late PostListController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<PostListController>();
    String targetTime =
        "${widget.selectedDate.year}-${widget.selectedDate.month.toString().padLeft(2, '0')}-${widget.selectedDate.day.toString().padLeft(2, '0')}";
    // 데이터를 가져오기 위해 Controller의 메소드를 호출
    controller.postlistFetchData(targetTime);
  }

  void toggleLike(PostList postList) {
    if (postList.like != true) {
      print("Liking Post No: ${postList.post_no}");
      detailController.pluslikefetchData(); // 좋아요 추가
    } else {
      detailController.minuslikefetchData(); // 좋아요 제거
    }

    // UI 업데이트
    setState(() {
      // postList.like = !postList.like!; // 좋아요 상태 토글
      // postList.like_count = postList.like! ? postList.like_count + 1 : postList.like_count - 1; // 좋아요 수 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            '${widget.selectedDate.year}년 ${widget.selectedDate.month}월 ${widget.selectedDate.day}일'),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Obx(() {
      // 리스트가 비어 있는 경우 처리
      if (controller.postlists.isEmpty) {
        return const Center(child: Text('데이터 없음'));
      }

      // 데이터가 있을 경우 ListView를 반환
      return ListView.builder(
        itemCount: controller.postlists.length,
        itemBuilder: (context, index) {
          PostList postList = controller.postlists[index];
          return _buildPostItem(postList);
        },
      );
    });
  }

  Widget _buildPostItem(PostList postList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(
                      postList.like != true
                          ? Icons.favorite_border
                          : Icons.favorite,
                      color: postList.like == true ? Colors.red : null,
                    ),
                    onPressed: () {
                      if (postList.post_no != null) {
                        toggleLike(postList);
                      } else {
                        print('Post number is null');
                      }
                    },
                  ),
                ),
                Text(
                  '${postList.like_count}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            _menuIcon(
              Get.context!,
              onEdit: () {
                Get.to(
                  () => UpdatePage(
                    photo_url: postList.photo_url,
                    content: postList.content,
                    postNo: postList.post_no,
                  ),
                );
              },
              onDelete: () {
                _confirmDelete(Get.context!, postList.post_no!);
              },
            ),
          ],
        ),
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Image.network(
            postList.photo_url ?? '',
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            postList.content ?? '',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _menuIcon(BuildContext context,
      {required Function onEdit, required Function onDelete}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.edit_outlined),
                    SizedBox(width: 8),
                    Text('수정하기'),
                  ],
                ),
                onTap: () => Future.microtask(() => onEdit()),
              ),
              PopupMenuItem(
                child: const Row(
                  children: [
                    Icon(Icons.delete_outline),
                    SizedBox(width: 8),
                    Text('삭제하기'),
                  ],
                ),
                onTap: () => Future.microtask(() => onDelete()),
              ),
            ];
          },
          icon: const Icon(Icons.more_vert),
          offset: const Offset(0, 50),
          color: Colors.white,
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context, int postNo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('삭제 확인'),
          content: const Text('정말로 삭제하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: const Text('아니요'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('예'),
              onPressed: () {
                Get.back();
                controller.deletefetchData(postNo);
                Get.off(() => App());
              },
            ),
          ],
        );
      },
    );
  }
}
