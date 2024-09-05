import 'dart:io';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pallet_project/src/controller/myprofilcontroller.dart';
import 'package:pallet_project/src/controller/usercontroller.dart';
import 'package:pallet_project/src/model/feed.dart';
import 'package:pallet_project/src/model/myprofil.dart';
import 'package:pallet_project/src/view/info_modify.dart';
import 'package:pallet_project/src/view/mydetail.dart';

class Profile extends GetView<MyProfilController> {
  const Profile({
    Key? key,
    // required BindingsBuilder binding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text(
              '나의 프로필',
              style: TextStyle(
                fontFamily: 'NanumGothic',
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [_profilmenu()],
          ),
          body: (controller.profile != null)
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _profileBox(controller.profile!),
                        const SizedBox(height: 20),
                        _postcount(controller.profile!),
                        const SizedBox(height: 20),
                        _myfeed(controller.profile!.myPost), // myPost 리스트를 전달
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator.adaptive(),
                )),
    );
  }

  Widget _profileBox(MyProfil profile) {
    double size = 100; // 고정된 크기 설정
    UserController controller = Get.find<UserController>();

    return Row(
      children: <Widget>[
        ClipOval(
          child: controller.isProfileImageSet
              ? Image.file(
                  File(controller.profileImagePath.value),
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.grey,
                  width: size,
                  height: size,
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
        ),
        const SizedBox(width: 14.0),
        Container(
          width: 200, // 고정된 너비 설정
          child: _miniinfo(profile),
        ),
      ],
    );
  }

  Widget _miniinfo(MyProfil profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${profile.name}',
          style: const TextStyle(fontSize: 18.0),
        ),
        Text(
          '${profile.id}',
          style: const TextStyle(fontSize: 17.0),
        ),
      ],
    );
  }

  Widget _postcount(MyProfil myprofile) {
    return Center(
      child: Container(
        width: 400, // 고정된 너비 설정
        height: 78,
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                // const Icon(Icons.edit),
                const Text('내가 쓴 글'),
                Text(
                  myprofile.total_post_count.toString(),
                ),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            // const Spacer(), // 요소 사이의 간격을 균등하게 조정
            Container(
              height: 40,
              width: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 30,
            ),
            // const Spacer(), // 요소 사이의 간격을 균등하게 조정
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Icon(
                //   Icons.favorite,
                //   color: Colors.red,
                const Text('좋아요 수'),

                Text(myprofile.total_like_count.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _myfeed(List<Feed> myPost) {
    return Container(
      height: 400, // 고정된 높이 설정
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
        ),
        itemCount: myPost.length,
        itemBuilder: (context, index) {
          Feed feed = myPost[index]; // myPost 리스트에서 Feed 객체 가져오기
          String? photoUrl = feed.photoUrl;

          return GestureDetector(
            onTap: () {
              // 원하는 페이지로 이동하는 코드 추가
              Get.to(() => MydetailPage(postNo: feed.postNo!));
            },
            child: Container(
              decoration: BoxDecoration(
                image: photoUrl != null
                    ? DecorationImage(
                        image: NetworkImage(photoUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: photoUrl == null ? Colors.grey : null,
              ),
              child: photoUrl == null
                  ? const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                        size: 40,
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _profilmenu() {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Row(
                    children: [
                      Icon(Icons.settings_outlined),
                      SizedBox(
                        width: 8,
                      ),
                      Text('정보 수정하기'),
                    ],
                  ),
                  onTap: () => _showPasswordBottomSheet(),
                ),
                PopupMenuItem(
                  child: const Row(
                    children: [
                      Icon(Icons.logout_outlined),
                      SizedBox(width: 8),
                      Text('로그아웃'),
                    ],
                  ),
                  onTap: () => {Get.find<UserController>().logoutfetchData()},
                ),
                PopupMenuItem(
                  child: const Row(
                    children: [
                      Icon(Icons.warning_outlined),
                      SizedBox(
                        width: 8,
                      ),
                      Text('탈퇴하기'),
                    ],
                  ),
                  onTap: () => {},
                ),
              ];
            },
            icon: const Icon(Icons.more_vert),
            offset: const Offset(0, 50),
            color: Colors.white, // 메뉴 배경색 변경
          ),
        ],
      ),
    );
  }

  void _showPasswordBottomSheet() {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _passwordController = TextEditingController();

    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '비밀번호 입력',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '비밀번호를 입력하세요.';
                  }

                  String correctPassword = UserController.to.password.text;
                  if (value != correctPassword) {
                    return '비밀번호가 틀립니다.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('취소'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Get.to(() => InfoModifyPage());
                        // Get.back();
                        // Get.to(() => InfoModifyPage());
                      }
                    },
                    child: const Text('확인'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
