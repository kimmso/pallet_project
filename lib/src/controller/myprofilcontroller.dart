import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:pallet_project/src/binding/init_binding.dart';

import 'package:pallet_project/src/model/myprofil.dart';

import 'package:pallet_project/src/repository/myprofil_repository.dart';
import 'package:pallet_project/src/view/login.dart';

class MyProfilController extends GetxController {
  final Rxn<MyProfil> _myprofils = Rxn<MyProfil>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  final MyProfilRepository repository;
  MyProfilController({
    required this.repository,
  });

  static MyProfilController get to => Get.find();

  TextEditingController get name => _name;
  TextEditingController get password => _password;
  TextEditingController get confirmpassword => _confirmpassword;

  MyProfil? get profile => _myprofils.value;

  @override
  void onInit() {
    myinfofetchData();
    super.onInit();
  }

  void updateMyProfile(String newName) {
    final newProfile = MyProfil(
        id: _myprofils.value!.id,
        name: newName,
        total_like_count: _myprofils.value!.total_like_count,
        total_post_count: _myprofils.value!.total_post_count,
        myPost: _myprofils.value!.myPost);

    _myprofils(newProfile);
  }

  void myinfofetchData() async {
    final myprofil = await repository.myinfoApi();

    _myprofils(myprofil);
  }

  validate(String value) {
    if (value.isEmpty) {
      Get.snackbar("변경 실패", "공백입니다.");
      throw Exception();
    }

    if (value.contains(" ")) {
      Get.snackbar("변경 실패", "공백이 존재합니다.");
      throw Exception();
    }
  }

  void nicknamefetchData() async {
    await validate(name.text.toString());

    final user = {
      'name': name.text.toString(),
    };

    final result = await repository.nicknameApi(user);

    updateMyProfile(result);

    moveToprofil();
  }

  Future<void> passwordfetchData() async {
    validate(password.text.toString());
    final user = {
      'password': confirmpassword.text.toString(),
    };
    repository.passwordApi(user);

    moveTologin();
  }

  void moveToprofil() {
    Get.until((route) => route.isFirst);
  }

  void moveTologin() {
    Get.off(() => LoginPage(), binding: InitBinding());
  }
}
