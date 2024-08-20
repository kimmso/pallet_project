import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallet_project/src/controller/detailcontroller.dart';
import 'package:pallet_project/src/controller/likecontroller.dart';
import 'package:pallet_project/src/model/feeddetail.dart';
import 'package:pallet_project/src/repository/detail_repository.dart';
import 'package:pallet_project/src/repository/like_repository.dart';

class DetailPage extends StatefulWidget {
  final int post_no;
  const DetailPage({Key? key, required this.post_no}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<FeedDetail?> _feeddetailsFuture;
  late DetailController detailController;
  late LikeController likeController;

  @override
  void initState() {
    super.initState();
    detailController =
        Get.put(DetailController(repository: DetailRepository()));
    likeController = Get.put(LikeController(repository: LikeRepository()));
    _feeddetailsFuture = detailController.detailfetchData(widget.post_no);
    _initializeLikeState();
  }

  Future<void> _initializeLikeState() async {
    FeedDetail? feedDetail =
        await detailController.detailfetchData(widget.post_no);
    if (feedDetail != null) {
      // 서버에서 받아온 데이터를 기반으로 초기 상태 설정
      likeController.isLiked.value =
          feedDetail.like!; // FeedDetail에 isLiked 속성이 있어야 합니다.
      likeController.like_count.value =
          feedDetail.like_count!; // FeedDetail에 like_count 속성이 있어야 합니다.
    }
  }

  void _toggleLike() async {
    if (likeController.isLiked.value) {
      await likeController.minuslikefetchData(widget.post_no);
    } else {
      await likeController.pluslikefetchData(widget.post_no);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder<FeedDetail?>(
          future: _feeddetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text('No data found');
            } else {
              return _username(snapshot.data!.name);
            }
          },
        ),
      ),
      body: FutureBuilder<FeedDetail?>(
        future: _feeddetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          } else {
            return _body(snapshot.data!);
          }
        },
      ),
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
          : Text('No Image'),
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
              : Text('No Content'),
        ),
      ),
    );
  }

  Widget _likeButton() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Obx(() {
        bool isLiked = likeController.isLiked.value;
        return IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : null,
          ),
          onPressed: _toggleLike,
        );
      }),
    );
  }

  Widget _likeCount() {
    return Obx(() {
      int like_count = likeController.like_count.value;
      return Text(
        '$like_count',
        style: TextStyle(fontSize: 16),
      );
    });
  }

  Widget _date(String? createDate) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          createDate != null ? '$createDate' : '날짜 정보 없음',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _username(String? name) {
    return Text(
      '$name 님의 게시글',
      style: const TextStyle(fontSize: 20.0),
    );
  }
}
