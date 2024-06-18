import 'package:flutter/material.dart';
import 'package:rahat_sat_project/features/colors.dart';
import 'package:rahat_sat_project/model/autho_response.dart';
import 'package:rahat_sat_project/model/login_model.dart';
import 'package:rahat_sat_project/screens/home_page_a.dart';
import 'package:rahat_sat_project/services/user_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: "sdds"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final UserClient userClient = UserClient();

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _passwordLock = false;
  bool _rememberMe = true;
  bool _login = false;

  void _incrementCounter() {
    setState(() {});
  }

  void initState() {
    super.initState();
    _login = true;
    //apicall
    //widget.userClient.Login(user).then((value) => null);
    print(_login);
  }

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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: onLoginButtonPress,
                      child: SizedBox(
                        height: 50,
                        child: FittedBox(
                          //burada belirli ölçüye göre sınırlandırması için kullandım
                          fit: BoxFit.scaleDown,
                          child: Container(
                            decoration: BoxDecoration(
                              //   color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(5),
                            child: const Text(
                              "Giriş Yap",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
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

/**
 * 
 * 
 * 
 *   void getProductsList() {
    setState(() {
      _login = true;
      widget.userClient
          .getProductList()
          .then((response) => onGetProductListSucces(response));
    });
  }

 onGetProductListSucces(List<ProductListListing>? products) {
    setState(() {
      if (products != null) {
        /*for (var product in products) {
          print(product.id); //burdan geliyor ürün özelliği
        }*/
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => ProductListView(inProductsList: products)));
      }
    });
  }
 * 
 * 
 * 
 */