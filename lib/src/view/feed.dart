import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallet_project/src/controller/feedcontroller.dart';

class FeedPage extends GetView<FeedController> {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Obx(() => Column(
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
                    return Container(
                        color: Colors.white,
                        child: Image.network(
                          controller.feeds[index].photoUrl ?? '',
                          fit: BoxFit.cover,
                        ));
                  },
                ),
              ),
              (controller.isLoading)
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Container(),
            ],
          )),
    );
  }
}
