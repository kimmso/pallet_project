import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:pallet_project/src/controller/feedcontroller.dart';
import 'package:pallet_project/src/model/feed.dart';
import 'package:pallet_project/src/view/detail.dart';

class FeedPage extends StatefulWidget {
  final FeedController controller;

  const FeedPage({required this.controller, Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late Future<List<Feed>?> _feedsFuture;

  @override
  void initState() {
    super.initState();

    _feedsFuture = widget.controller.feedFetchData();
  }

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
      body: _Feed(),
    );
  }

  Widget _Feed() {
    return FutureBuilder<List<Feed>?>(
      future: _feedsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('에러: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text('데이터 없음'),
          );
        } else {
          List<Feed> feeds = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
            ),
            itemBuilder: (context, index) {
              if (index < feeds.length) {
                Feed feed = feeds[index];
                return GestureDetector(
                  // GestureDetector 추가
                  onTap: () {
                    // onTap 콜백 추가
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(post_no: feed.post_no!),
                        // DetailPage로 이동
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.blueGrey,
                    child: Image.network(
                      feed.photo_url ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                // Fetching more data if this is the last item in the grid
                if (feeds.length % 18 == 0) {
                  String? post_no = feeds.last.post_no.toString();
                  GetStorage().write('post_no', post_no);
                  print("Saved post number: $post_no");
                  widget.controller
                      .secondFetchData()
                      .then((List<Feed>? newData) {
                    if (newData != null && newData.isNotEmpty) {
                      setState(() {
                        feeds.addAll(newData);
                      });
                    }
                  });
                }
                return Container();
              }
            },
            itemCount: feeds.length +
                1, // Add one to account for possible loading indicator
          );
        }
      },
    );
  }
}
