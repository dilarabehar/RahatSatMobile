import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:rahat_sat_proje/features/colors.dart';
import 'package:rahat_sat_proje/riverpod/riverpod_management.dart';
import 'package:rahat_sat_proje/screens/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {

  bool _passwordLock = false;
  bool _rememberMe = true;
  
  get ref => context;
  

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
        decoration:ColorsDecoration.loginDecoration,
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
                  /*Text(
                      textAlign: TextAlign.left,
                      "Giriş Yap",
                      style: TextStyle(
                          color: Colors.deepPurple[400],
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 50)
                          ),
                  const SizedBox(height: 25),*/
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                        controller: ref.read(loginRiverpod).usernameController,
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
                      controller: ref.read(loginRiverpod).passwordController,
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
                  onPressed: () => ref.read(loginRiverpod).fetch(),
                  child: const Text(
                    "Giriş Yap",
                  ),
                /*  GestureDetector(
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())),
                    onTap: () => ref.read(loginRiverpod).fetch(),
                    child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                            child: Text(
                          "Giriş Yap",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.deepPurple),
                        ))),
                  )*/
              ))],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
