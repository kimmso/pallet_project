import 'package:get/get.dart';
import 'package:pallet_project/src/controller/bottomcontroller.dart';
import 'package:pallet_project/src/controller/calendercontroller.dart';
import 'package:pallet_project/src/controller/emailcontroller.dart';
import 'package:pallet_project/src/controller/feedcontroller.dart';
import 'package:pallet_project/src/controller/homecontroller.dart';
import 'package:pallet_project/src/controller/postlistcontroller.dart';
import 'package:pallet_project/src/controller/usercontroller.dart';
import 'package:pallet_project/src/repository/calender_repository.dart';
import 'package:pallet_project/src/repository/email_repository.dart';
import 'package:pallet_project/src/repository/feed_repository.dart';
import 'package:pallet_project/src/repository/postlist_repository.dart';
import 'package:pallet_project/src/repository/user_repository.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController());
    Get.put(HomeController());
    Get.put(FeedController(repository: FeedRepository()));
    Get.put(UserController(repository: UserRepository()));
    Get.put(EmailController(repository: EmailRepository()));
    Get.put(PostListController(repository: PostListRepository()));
    Get.put(CalenderDateController(repository: CalenderDateRepository()));
  }
}
