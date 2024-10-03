import 'dart:io';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pallet_project/src/controller/calendercontroller.dart';
import 'package:pallet_project/src/controller/feedcontroller.dart';

import 'package:pallet_project/src/controller/myprofilcontroller.dart';

enum Page { HOME, Feed, Profil }

class BottomNavController extends GetxController {
  String targetTime = DateFormat('yyyy-MM').format(DateTime.now());
  final RxInt _pageIndex = 0.obs;

  final List<int> _history = [0];

  int get index => _pageIndex.value;

  void changeIndex(int value) {
    var page = Page.values[value];
    switch (page) {
      case Page.HOME:
        CalenderDateController calenderDateController = Get.find();
        calenderDateController.calenderdateFetchData(targetTime);
        moveToPage(value);
        break;
      case Page.Feed:
        moveToPage(value);

        // FeedController를 가져와서 새로 데이터를 불러오는 로직 추가
        FeedController feedController = Get.find();
        feedController.feedFetchData(); // 데이터를 다시 불러오는 메서드 호출
        break;
      case Page.Profil:
        MyProfilController myProfilController = Get.find();
        myProfilController.myinfofetchData();
        moveToPage(value);

        // UserController controller = Get.find(); // Get.find()로 컨트롤러에 접근
        // controller.myinfoFetchData(); // UPLOAD 페이지에서는 myInfo 메소드 실행
        break;
    }
  }

  void moveToPage(int value) {
    if (_history.last != value && Platform.isAndroid && Platform.isIOS) {
      _history.add(value);
      print(_history);
    }
    _pageIndex(value);
  }
}
