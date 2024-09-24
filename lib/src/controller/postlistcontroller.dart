import 'package:get/get.dart';
import 'package:pallet_project/src/model/postlist.dart';
import 'package:pallet_project/src/repository/postlist_repository.dart';

class PostListController extends GetxController {
  final Rx<List<PostList>> _postlists = Rx<List<PostList>>([]);

  var profileImagePath = ''.obs;
  List<PostList> get postlists => _postlists.value;
  final PostListRepository repository;
  PostListController({
    required this.repository,
  });

  Future<List<PostList>?> postlistFetchData(String targetTime) async {
    try {
      final postlist = await repository.postlistApi(targetTime); // 비동기 작업을 기다림
      _postlists.value = postlists;

      return postlist;
    } catch (e) {
      // Dio 오류 또는 다른 예외 처리
      print('User 정보를 가져오는 도중 오류가 발생했습니다: $e');
      throw Exception();
    }
  }

  Future<void> deletefetchData(int postNo) async {
    try {
      await repository.deleteApi(postNo);

      Get.snackbar('삭제 완료', '게시글이 삭제되었습니다.');
    } catch (e) {
      Get.snackbar('삭제 실패', '게시글 삭제에 실패했습니다. 다시 시도해주세요.');
    }
  }
}
