import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallet_project/src/controller/emailcontroller.dart';
import 'package:pallet_project/src/controller/usercontroller.dart';
import 'package:pallet_project/src/utils/validator.dart';
import 'package:pallet_project/src/view/login.dart';
import 'package:pallet_project/src/widget/elevatedbutton.dart';
import 'package:pallet_project/src/widget/textfield.dart';

class SignUpPage extends GetView<UserController> {
  // State를 유지하기 위해 authcode를 final로 설정합니다.
  final String? authcode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignUpPage({super.key}) : authcode = null;

  @override
  Widget build(BuildContext context) {
    final EmailController emailController = Get.find();
    final TextEditingController authcodeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(() => LoginPage());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: const Text(
                '회원가입',
                style: TextStyle(
                    color: Color.fromARGB(255, 129, 132, 211),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            _signUpForm(emailController, authcodeController),
          ],
        ),
      ),
    );
  }

  Widget _signUpForm(EmailController emailController,
      TextEditingController authcodeController) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hint: "이름",
            controller: controller.name,
            validator: (String) {},
          ),
          CustomTextField(
            hint: "이메일",
            validator: ValidatorUtil.validateEmail,
            controller: controller.signupId,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextButton(
                child: const Text('인증하기'),
                onPressed: () async {
                  try {
                    // 이메일 인증 코드 요청
                    final receivedAuthcode = await emailController
                        .authFetchData(controller.signupId.text);

                    // 인증 코드 저장
                    controller.setAuthCode(receivedAuthcode);

                    Get.snackbar(
                      "인증메일 전송",
                      "인증메일이 성공적으로 전송되었습니다.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Color.fromARGB(255, 129, 132, 211),
                      colorText: Colors.white,
                    );
                    // 이메일 인증 상태 업데이트
                    controller.setEmailVerified(false);
                  } catch (e) {
                    Get.snackbar(
                      "오류",
                      "인증메일 전송에 실패했습니다. 다시 시도해 주세요.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
            ),
          ),
          CustomTextField(
            hint: "이메일 인증번호",
            controller: authcodeController,
            validator: ValidatorUtil.validateConfirmCode,
            suffixIcon: Padding(
              padding: EdgeInsets.all(6.0),
              child: TextButton(
                onPressed: () {
                  final inputCode = authcodeController.text;
                  final savedCode = controller.authcode;

                  // 사용자가 입력한 코드와 저장된 코드 비교
                  if (inputCode == savedCode) {
                    Get.snackbar(
                      "인증 성공",
                      "인증번호가 확인되었습니다.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Color.fromARGB(255, 129, 132, 211),
                      colorText: Colors.white,
                    );
                    // 이메일 인증 상태 업데이트
                    controller.setEmailVerified(true);
                  } else {
                    Get.snackbar(
                      "인증 실패",
                      "입력한 인증번호가 올바르지 않습니다.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Text('확인'),
              ),
            ),
          ),
          CustomTextField(
            hint: "비밀번호",
            validator: ValidatorUtil.validatePassword,
            controller: controller.signupPassword,
          ),
          CustomTextField(
            hint: "비밀번호 확인",
            validator: (value) => ValidatorUtil.validateConfirmPassword(
                value, controller.confirmPassword.text),
            controller: controller.confirmPassword,
          ),
          Obx(() {
            return CustomElevatedButton(
              text: "회원가입",
              onPressed: () {
                if (_formKey.currentState!.validate() &&
                    controller.isEmailVerified.value) {
                  controller.signupFetchData();
                } else {
                  Get.snackbar(
                    "회원가입 시도",
                    controller.isEmailVerified.value
                        ? "회원가입 실패"
                        : "이메일 인증을 완료해 주세요.",
                  );
                }
              },
              enabled: controller.isEmailVerified.value,
            );
          }),
        ],
      ),
    );
  }
}
