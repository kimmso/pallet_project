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

class App extends GetView<BottomNavController> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // 컨트롤러를 초기화합니다.
    Get.put(BottomNavController());
    Get.put(MyProfilController(repository: MyProfilRepository()));
    Get.put(FeedController(repository: FeedRepository()));

    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.index,
          children: [
            Home(),
            FeedPage(),
            Navigator(
              key: Get.nestedKey(1),
              onGenerateRoute: (settings) {
                return GetPageRoute(page: () => const Profile());
              },
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.index,
          onTap: (index) {
            controller.changeIndex(index);
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
        );
      }),
    );
  }
}
