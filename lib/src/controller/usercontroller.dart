import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallet_project/src/app.dart';
import 'package:pallet_project/src/binding/init_binding.dart';
import 'package:pallet_project/src/model/user.dart';
import 'package:pallet_project/src/repository/user_repository.dart';
import 'package:pallet_project/src/view/login.dart';
import 'package:pallet_project/src/view/signup.dart';

class UserController extends GetxController {
  final Rxn<User> _users = Rxn<User>();

  var profileImagePath = ''.obs;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _id = TextEditingController();
  final TextEditingController _signupId = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _signupPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _newpassword = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  final TextEditingController _authcode = TextEditingController();

  final UserRepository repository;
  UserController({
    required this.repository,
  });

  TextEditingController get name => _name;
  TextEditingController get id => _id;
  TextEditingController get signupId => _signupId;
  TextEditingController get password => _password;
  TextEditingController get signupPassword => _signupPassword;
  TextEditingController get confirmPassword => _confirmPassword;
  TextEditingController get newpassword => _newpassword;
  TextEditingController get confirm => _confirm;
  TextEditingController get authcode => _authcode;

  // Rx 변수를 통해 user 객체에 접근할 수 있는 getter 추가
  User? get user => _users.value;

  validate(String value) {
    if (value == null || value.isEmpty) {
      return "공백이 들어갈 수 업습니다.";
    } else if (value.length > 12) {
      return "패스워드의 길이를 초과하였습니다.";
    } else if (value.length < 4) {
      return "패스워드의 최소 길이는 4자입니다";
    } else {
      return null;
    }
  }

  void fetchData() {
    final user = {
      'id': id.text.toString(),
      'password': password.text.toString(),
    };

    repository.loginApi(user).then((user) {
      if (user != null) {
        _users.value = user;
        moveToApp();
      } else {
        Get.snackbar(
          "로그인 실패",
          "아이디 또는 비밀번호가 틀렸습니다.",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    });
  }

  void putData() {
    final user = {
      'id': _id.value.text,
      'password': _password.value.text.toString()
    };
    repository.putUsers(user);
  }

  void signupFetchData() {
    final user = {
      'id': signupId.text.toString(),
      'name': name.text.toString(),
      'password': signupPassword.text.toString(),
    };

    repository.signupApi(user).then((user) {
      _users.value = user;
      moveToLogin();
    });
  }

  void signupPutData() {
    final signup = {
      'id': _signupId.value.text,
      'name': _name.value.text,
      'password': _signupPassword.value.text.toString(),
    };
    repository.putSignups(signup);
  }

  void logoutfetchData() {
    repository.logoutApi();
  }

  void logoutputData() {
    final user = {
      'id': _id.value.text,
      'password': _password.value.text.toString()
    };
    repository.putUsers(user);
  }

  void changepasswordfetchData(String newpassword) {
    validate(newpassword.toString());
    final user = {
      'password': newpassword,
    };
    repository.changepasswordApi(newpassword);

    moveToLogin();
  }

// 화면 크기별 위젯 능동적 조정
  late double screenWidth = 0.0;
  late double screenHeight = 0.0;

  void initScreenWidth(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

// SignUp view 이동
  void moveToRegister() {
    Get.to(() => SignUpPage(), binding: InitBinding());
  }

  // Login view 이동
  void moveToLogin() {
    Get.to(() => LoginPage(), binding: InitBinding());
  }

//App.dart 화면으로 이동
  void moveToApp() {
    Get.to(() => const App(), binding: InitBinding());
  }

  bool get isProfileImageSet => profileImagePath.value.isNotEmpty;
}
