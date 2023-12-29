import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:rahat_sat_project/features/loading_popup.dart';
import 'package:rahat_sat_project/screens/home_page_a.dart';
import 'package:rahat_sat_project/services/login_service.dart';

class LoginRiverpod extends ChangeNotifier {
  final service = Service();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void fetch() {
    loadingPopup();
    service
        .loginCall(
            email: usernameController.text, password: passwordController.text)
        .then((value) {
      if (value?.message == "Giriş başarılı") {
        Grock.back();
        Grock.toRemove(const HomePage());
      } else {
        Grock.back();
        Grock.snackBar(
            title: "Hata",
            description: value?.message ?? "Bir sorun oluştu, tekrar deneyin.");
      }
    });
  }
}
