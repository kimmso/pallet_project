import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallet_project/src/controller/feedcontroller.dart';
import 'package:pallet_project/src/view/detail.dart';

import 'package:pallet_project/src/view/mydetail.dart'; // MydetailPage를 포함시킵니다.

class FeedPage extends GetView<FeedController> {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text(
            'PALETTE',
            style: TextStyle(
              fontFamily: 'NanumGothic',
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: controller.scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                ),
                itemCount: controller.feeds.length,
                itemBuilder: (context, index) {
                  final feed = controller.feeds[index];

                  return GestureDetector(
                    onTap: () {
                      final postNo = feed.postNo;

                      Get.to(() => DetailPage(postNo: postNo!));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        feed.photoUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (controller.isLoading)
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
          ],
        ),
      ),
    );
  }
}
