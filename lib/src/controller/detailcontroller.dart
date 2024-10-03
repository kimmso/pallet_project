import 'package:get/get.dart';
import 'package:pallet_project/src/model/feeddetail.dart';
import 'package:pallet_project/src/repository/detail_repository.dart';

class DetailController extends GetxController {
  final Rxn<FeedDetail> _feeddetails = Rxn<FeedDetail>();

  var isLiked = false.obs;
  var like_count = 0.obs;
  var postNo = 0.obs;

  final DetailRepository repository;

  DetailController({
    required this.repository,
  });

  FeedDetail? get feeddetails => _feeddetails.value;

  Future<FeedDetail?> detailfetchData(int postNo) async {
    final feeddetail = await repository.detailApi(postNo);

    if (feeddetail != null) {
      _feeddetails.value = feeddetail;
      isLiked.value = feeddetail.like ?? false; // 데이터를 기반으로 isLiked 설정
      like_count.value = feeddetail.like_count ?? 0; // 데이터에 기반하여 좋아요 카운트 설정
      this.postNo.value = postNo; // postNo 설정
      return feeddetail;
    } else {
      return null;
    }
  }

  Future<void> pluslikefetchData() async {
    bool? response = await repository.likeApi(postNo.value); // postNo 사용

    if (response == true) {
      isLiked.value = true; // API 응답이 성공적일 때 좋아요 상태 변경
      like_count.value++; // 좋아요 수 증가
    } else {
      print('좋아요 실패');
    }
  }

  Future<void> minuslikefetchData() async {
    bool? response = await repository.minuslikeApi(postNo.value);

    if (response == true) {
      isLiked.value = false; // 좋아요 상태 변경
      if (like_count.value > 0) {
        like_count.value--; // 좋아요 숫자 1 감소 (0 미만으로 가지 않도록 체크)
      }
    } else {
      print('마이너스 실패');
    }
  }
}
