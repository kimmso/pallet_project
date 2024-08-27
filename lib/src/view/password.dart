import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pallet_project/src/controller/myprofilcontroller.dart';
import 'package:pallet_project/src/controller/usercontroller.dart';
import 'package:pallet_project/src/widget/elevatedbutton.dart';
import 'package:pallet_project/src/widget/textfield.dart';

class PasswordPage extends GetView<UserController> {
  PasswordPage({super.key});
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('비밀번호 변경하기'),
        ),
        body: _password());
  }

  Widget _password() {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hint: "새로운 비밀번호",
              validator: (String) {},
              controller: MyProfilController.to.password,
            ),
            CustomTextField(
              hint: "새로운 비밀번호 확인",
              validator: (String) {},
              controller: MyProfilController.to.confirmpassword,
            ),
            CustomElevatedButton(
              text: "비밀번호 변경 완료",
              onPressed: () {
                final MyProfilController controller =
                    Get.find<MyProfilController>();
                if (_formkey.currentState!.validate()) {
                  controller.passwordfetchData();
                  Get.snackbar("비밀번호 변경 성공", "성공");
                } else {
                  Get.snackbar("비밀번호 변경 실패", "실패");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
