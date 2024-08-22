import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallet_project/src/app.dart';
import 'package:pallet_project/src/binding/init_binding.dart';
import 'package:pallet_project/src/model/user.dart';
import 'package:pallet_project/src/repository/user_repository.dart';
import 'package:pallet_project/src/view/login.dart';
import 'package:pallet_project/src/view/signup.dart';

class UserController extends GetxController {
  final Rxn<User> _user = Rxn<User>();

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
  TextEditingController get iauthcode => _authcode;

  static UserController get to => Get.find();

  // Rx 변수를 통해 user 객체에 접근할 수 있는 getter 추가
  User? get user => _user.value;

  void updateUser(User user) {
    _user(user);
    _user.refresh();
  }

  // validate 메서드 수정: null 검사 제거
  String? validate(String value) {
    if (value.isEmpty) {
      return "공백이 들어갈 수 없습니다."; // 공백 검사를 위한 수정
    } else if (value.length > 12) {
      return "패스워드의 길이를 초과하였습니다."; // 길이 초과 검사
    } else if (value.length < 4) {
      return "패스워드의 최소 길이는 4자입니다"; // 길이 부족 검사
    } else {
      return null;
    }
  }

  var isEmailVerified = false.obs; // 이메일 인증 상태를 RxBool로 선언
  String? authcode; // 인증 코드를 저장할 변수

  void setEmailVerified(bool verified) {
    isEmailVerified.value = verified;
  }

  void setAuthCode(String? code) {
    authcode = code;
  }

  void fetchData() {
    final user = {
      'id': id.text.toString(),
      'password': password.text.toString(),
    };

    repository.loginApi(user).then((user) {
      if (user != null) {
        _user.value = user;
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
      _user.value = user;
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

  void changepasswordfetchData(String newpassword, String saveEmail) {
    validate(newpassword.toString());
    final user = {
      'id': saveEmail,
      'password': newpassword,
    };
    repository.changepasswordApi(newpassword, saveEmail);

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
    Get.off(() => const App(), binding: InitBinding());
  }

  bool get isProfileImageSet => profileImagePath.value.isNotEmpty;
}
