import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pallet_project/src/controller/emailcontroller.dart';
import 'package:pallet_project/src/widget/elevatedbutton.dart';

class FindPasswordPage extends GetView<EmailController> {
  const FindPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('비밀번호 찾기'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '이메일을 입력해주세요.',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '이메일',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '이메일을 입력하세요.';
                    }

                    final emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return '올바른 이메일 형식이 아닙니다.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return controller.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomElevatedButton(
                          text: "확인",
                          onPressed: controller.validationEmail,
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
