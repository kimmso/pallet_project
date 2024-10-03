import 'package:get/get.dart';

import 'package:pallet_project/src/model/postlist.dart';
import 'package:pallet_project/src/repository/postlist_repository.dart';

class PostListController extends GetxController {
  var postlists = <PostList>[].obs; // RxList로 선언
  // final Rx<List<PostList>> _postlists = Rx<List<PostList>>([]);

  var profileImagePath = ''.obs;
  // List<PostList> get postlists => _postlists.value;
  final PostListRepository repository;

  PostListController({
    required this.repository,
  });

  Future<List<PostList>?> postlistFetchData(String targetTime) async {
    try {
      final postlist = await repository.postlistApi(targetTime);
      postlists.value = postlist ?? [];
      print("ㄴㄴㄴㄴㄴ");
      print(postlist);
      return postlist;
    } catch (e) {
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

  // void toggleLike(PostList post) {
  //   if (post.isLiked == true) {
  //     minuslikefetchData(post);
  //   } else {
  //     pluslikefetchData(post);
  //   }
  // }

  // Future<void> pluslikefetchData(PostList post) async {
  //   repository.likeApi(post.post_no!);

  //   // 업데이트된 상태로 변경 (copyWith 사용)
  //   var updatedPost = post.copyWith(
  //     isLiked: true,
  //     like_count: post.like_count! + 1,
  //   );

  //   // 상태 갱신
  //   _updatePostInList(updatedPost);
  // }

  // Future<void> minuslikefetchData(PostList post) async {
  //   await repository.minuslikeApi(post.post_no!);

  //   // 업데이트된 상태로 변경 (copyWith 사용)
  //   var updatedPost = post.copyWith(
  //     isLiked: false,
  //     like_count: post.like_count! - 1,
  //   );

  //   // 상태 갱신
  //   _updatePostInList(updatedPost);
  // }

  // void _updatePostInList(PostList updatedPost) {
  //   // 기존 리스트에서 해당 postNo을 가진 포스트를 찾아서 업데이트
  //   int index = _postlists.value
  //       .indexWhere((post) => post.post_no == updatedPost.post_no);
  //   if (index != -1) {
  //     _postlists.value[index] = updatedPost;
  //     _postlists.refresh(); // 리스트 변경 사항을 UI에 반영
  //   }
  // }
}
