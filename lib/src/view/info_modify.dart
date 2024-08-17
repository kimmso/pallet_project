import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pallet_project/src/controller/myprofilcontroller.dart';
import 'package:pallet_project/src/controller/usercontroller.dart';
import 'package:pallet_project/src/view/password.dart';
import 'package:pallet_project/src/widget/elevatedbutton.dart';
import 'package:pallet_project/src/widget/textfield.dart';

class InfoModifyPage extends GetView<UserController> {
  InfoModifyPage({super.key});
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('정보 수정하기'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: MyProfilController.to.name,
                  hint: "이름",
                  validator: (String) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomElevatedButton(
                  text: "이름 수정 완료하기",
                  onPressed: () {
                    final MyProfilController controller =
                        Get.find<MyProfilController>();
                    if (_formkey.currentState!.validate()) {
                      controller.nicknamefetchData();
                    } else {
                      Get.snackbar("이름 바꾸기 성공", "실패");
                    }
                  },
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => PasswordPage());
                  },
                  child: const Text(
                    "비밀번호를 변경하시겠습니까?",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
