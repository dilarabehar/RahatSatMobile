import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:rahat_sat_project/features/colors.dart';
import 'package:rahat_sat_project/model/autho_response.dart';
import 'package:rahat_sat_project/model/login_model.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:rahat_sat_project/screens/forgot_password.dart';
import 'package:rahat_sat_project/screens/home_page_a.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class LoginPage extends StatefulWidget {
  final UserClient userClient = UserClient();

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _passwordLock = false;
  bool _rememberMe = true;
  bool _login = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void onLoginButtonPress() {
    setState(() {
      _login = true;
      LoginModel user = LoginModel(
          email: emailController.text, password: passwordController.text);
      widget.userClient
          .Login(user)
          .then((response) => {onLoginCallCompleted(response)});

      print(emailController.text);
    });
  }

  void onLoginCallCompleted(var response) {
    if (response == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("LOGIN FAILURE")));
    } else {
      if (response is AuthResponse) {
        getProducts();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }
    setState(() {
      _login = false;
    });
  }

  void getProducts() {
    setState(() {
      _login = true;
      widget.userClient
          .getProduct()
          .then((response) => onGetProductSucces(response));
    });
  }

  onGetProductSucces(List<SoldListing>? products) {
    setState(() {
      if (products != null) {
        for (var product in products) {
          print(product.id);
        }
      }
    });
  }

  void _passwordHidden() {
    setState(() {
      _passwordLock = !_passwordLock;
    });
  }

  void _rememberMeFunction() {
    setState(() {
      _rememberMe = !_rememberMe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ColorsDecoration.loginDecoration,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.shopify_rounded,
                    size: 200,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                        controller: emailController,
                        obscureText: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_sharp),
                          prefixIconColor: Colors.deepPurple,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.deepPurple)),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "E-Posta",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                        ),
                        autofillHints: const [AutofillHints.email]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: passwordController,
                      obscureText: !_passwordLock,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          icon: Icon(_passwordLock
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: _passwordHidden,
                        ),
                        prefixIconColor: Colors.deepPurple,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.deepPurple.shade700),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(color: Colors.deepPurple)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Şifre",
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                            icon: Icon(
                              _rememberMe
                                  ? Icons.check_box_outline_blank
                                  : Icons.check_box_outlined,
                              color: Colors.white,
                            ),
                            onPressed: _rememberMeFunction,
                            label: const Text(
                              "Beni Hatırla",
                              style: TextStyle(color: Colors.white),
                            )),
                        TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPassword())),
                            child: const Text(
                              "Şifremi Unuttum",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: Grock.width,
                    child: ElevatedButton(
                      onPressed: onLoginButtonPress,
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(
                              "Giriş Yap",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
