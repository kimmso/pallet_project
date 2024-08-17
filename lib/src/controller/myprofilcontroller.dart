import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pallet_project/src/binding/init_binding.dart';
import 'package:pallet_project/src/model/myprofil.dart';
import 'package:pallet_project/src/repository/myprofil_repository.dart';
import 'package:pallet_project/src/view/login.dart';
import 'package:pallet_project/src/view/profil.dart';

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

  Future<MyProfil?> myinfofetchData() async {
    final myprofil = await repository.myinfoApi();
    if (myprofil != null) {
      _myprofils.value = myprofil;

      return myprofil;
    } else {}
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

  Future<void> nicknamefetchData() async {
    validate(name.text.toString());

    final user = {
      'name': name.text.toString(),
    };

    final result = await repository.nicknameApi(user);

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
}

void moveToprofil() {
  Get.off(() => Profile());
}

void moveTologin() {
  Get.off(() => LoginPage(), binding: InitBinding());
}
