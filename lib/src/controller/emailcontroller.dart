import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pallet_project/src/repository/email_repository.dart';
import 'package:pallet_project/src/view/getnumber.dart';

class EmailController extends GetxController {
  final EmailRepository repository;
  final RxBool _isLoading = false.obs;
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final RxString _saveEmail = ''.obs;

  EmailController({
    required this.repository,
  });

  TextEditingController get email => _email;
  GlobalKey<FormState> get formKey => _formKey;
  bool get isLoading => _isLoading.value;
  String get savedEmail => _saveEmail.value; // savedEmail getter 추가

  void validationEmail() {
    if (_formKey.currentState!.validate()) {
      _saveEmail.value = _email.text; // 이메일 저장
      emailFetchData();
    }
  }

  // 이메일 데이터를 가져오는 메서드
  void emailFetchData() async {
    _isLoading(true);
    try {
      final code = await repository.emailApi(_saveEmail.value); // 저장된 이메일로 호출
      _isLoading(false);
      Get.to(() => GetNumberPage(code: code!));
    } on Exception catch (err) {
      _isLoading(false); // 실패 시에도 로딩 상태 해제
      print(err.toString());
    }
  }

  Future<String?> authFetchData(String email) async {
    _isLoading(true);
    try {
      final code = await repository.emailApi(email);
      _isLoading(false);
      return code;
    } on Exception catch (err) {
      _isLoading(false);
      print(err.toString());
      return null;
    }
  }

  // 6자리 랜덤 코드를 생성하는 메서드
  int _generateRandomCode() {
    final random = Random();
    return 100000 + random.nextInt(900000); // 100000 ~ 999999 사이의 랜덤 숫자 생성
  }
}
