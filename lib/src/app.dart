import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallet_project/src/controller/bottomcontroller.dart';
import 'package:pallet_project/src/controller/feedcontroller.dart';
import 'package:pallet_project/src/controller/myprofilcontroller.dart';
import 'package:pallet_project/src/repository/feed_repository.dart';
import 'package:pallet_project/src/repository/myprofil_repository.dart';
import 'package:pallet_project/src/view/feed.dart';
import 'package:pallet_project/src/view/home.dart';
import 'package:pallet_project/src/view/profil.dart';
import 'package:pallet_project/src/widget/image_data.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // 컨트롤러를 초기화합니다.
    Get.put(BottomNavController()); // BottomNavController를 초기화합니다.
    Get.put(MyProfilController(
        repository: MyProfilRepository())); // MyProfilController를 초기화합니다.
    Get.put(FeedController(
        repository: FeedRepository())); // FeedController를 초기화합니다.

    return Obx(() {
      // 상태를 관찰하고 필요한 경우 UI를 업데이트합니다.
      final bottomNavController = Get.find<BottomNavController>();

      print("Current Index: ${bottomNavController.index}"); // 디버깅 정보 출력

      return Scaffold(
        body: IndexedStack(
          index: bottomNavController.index,
          children: [
            Home(),
            FeedPage(controller: Get.find<FeedController>()),
            Profile(), // Profile 위젯에서 Binding을 추가로 설정할 필요 없음
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNavController.index,
          onTap: (index) {
            print("Tapped Index: $index"); // 탭된 인덱스 디버깅
            bottomNavController.changeIndex(index);
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: ImageData(path: ImagePath.homeOff),
              activeIcon: ImageData(path: ImagePath.homeOn),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: ImageData(path: ImagePath.noteTextOff),
              activeIcon: ImageData(path: ImagePath.noteTextOn),
              label: 'feed',
            ),
            BottomNavigationBarItem(
              icon: ImageData(path: ImagePath.userAltOff),
              activeIcon: ImageData(path: ImagePath.userAltOn),
              label: 'myinfo',
            ),
          ],
        ),
      );
    });
  }
}
