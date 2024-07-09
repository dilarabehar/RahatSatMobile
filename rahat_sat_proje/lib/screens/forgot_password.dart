import 'package:flutter/material.dart';
import 'package:rahat_sat_project/screens/login_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 128, 47, 175),
              Color.fromARGB(255, 80, 43, 187),
              Color.fromARGB(192, 91, 67, 196)
            ])),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                        obscureText: false,
                        decoration: InputDecoration(
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
                        autofillHints: [AutofillHints.email]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 5),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>  LoginPage())),
                    child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                            child: Text(
                          "Şifre Yenile ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.deepPurple),
                        ))),
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
