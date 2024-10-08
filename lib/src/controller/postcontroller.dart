import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pallet_project/src/model/post.dart';
import 'package:pallet_project/src/repository/post_repository.dart';

class PostController extends GetxController {
  final Rxn<Post> _posts = Rxn<Post>();
  final Rxn<Post> _contents = Rxn<Post>();

  final Rxn<XFile?> _file = Rxn<XFile?>();

  late TextEditingController _content;
  final RxBool _share_check = false.obs;

  late String hint = "";

  TextEditingController get content => _content;
  RxBool get shareCheck => _share_check;
  XFile? get file => _file.value;

  get isDateSelected => null;

  // 체크박스 상태를 업데이트하는 함수
  void updateCheckbox(bool value) {
    _share_check.value = value;
  }

  final PostRepository repository;
  PostController({
    required this.repository,
  });

  static PostController get to => Get.find();

  Future<void> pickImageV02() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        _file.value = image;
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<Post?> postfetchData() async {
    final post = await repository.writeApi(file);
    if (post != null) {
      _posts.value = post;
      return post;
    } else {
      Get.snackbar(
        "글쓰기 실패",
        "포스트 생성 실패",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return null;
    }
  }

  void postputData() {
    final post = {
      'content': _content.value.text,
    };
    repository.putPosts(post);
  }

  void contentFetchData(post) {
    final content = {
      'content': _content.value.text,
      'photo_url': post.photo_url,
      'share_check': _share_check.value == true,
    };

    repository.contentApi(content);
  }

  void contentPutData() {
    print('_share_check.value: ${_share_check.value}'); // 디버깅 메시지 추가

    final content = {
      'content': _content.value.text,
      'share_check': _share_check.value == true, // 문자열을 bool로 변환
    };
    repository.putContents(content);
  }

  void initTextField(String? hint) {
    _content = TextEditingController(text: hint ?? "");
  }

  Future<Post?> changepostfetchData(int postNo, String photo_url) async {
    print(1);

    // file이 null인 경우, 기존의 photo_url을 반환
    if (file == null) {
      // 기존에 가지고 있는 post 데이터의 photo_url을 반환
      print("??");
      print(photo_url);

      // Post 생성자를 사용하여 새로운 Post 객체를 만듭니다
      Post post = Post(
        content: _content.value.text,
        photo_url: photo_url,
        share_check: _share_check.value,
      );

      return post;
    }

    final post = await repository.changeimageApi(file, postNo);
    print(2);
    if (post != null) {
      _posts.value = post;
      return post;
    } else {
      Get.snackbar(
        "글 수정하기 실패",
        "수정 실패",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void changecontentFetchData(post, int postNo) {
    final content = {
      'content': _content.value.text,
      'photo_url': post.photo_url,
      'share_check': _share_check.value == true,
    };

    repository.changecontentApi(content, postNo);
  }
}
