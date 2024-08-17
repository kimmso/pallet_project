import 'package:get/get.dart';

enum Page { HOME, SEARCH, UPLOAD }

class BottomNavController extends GetxController {
  final RxInt _pageIndex = 0.obs;
  final List<int> _history = [0];

  int get index => _pageIndex.value;

  // 현재 페이지 인덱스에 따라 페이지를 변경합니다.
  void changeIndex(int value) {
    if (value < 0 || value >= Page.values.length) return; // 유효성 검사

    if (_pageIndex.value != value) {
      moveToPage(value);

      // 특정 페이지에서만 실행될 로직이 있다면, 여기에 추가합니다.
      switch (Page.values[value]) {
        case Page.UPLOAD:
          // UserController controller = Get.find();
          // controller.myinfoFetchData(); // UPLOAD 페이지에서는 myInfo 메소드 실행
          break;
        default:
          break;
      }
    }
  }

  // 페이지를 이동하고 히스토리를 관리합니다.
  void moveToPage(int value) {
    if (_history.last != value) {
      _history.add(value);
      print(_history);
    }
    _pageIndex(value);
  }
}
