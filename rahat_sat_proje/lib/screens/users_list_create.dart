import 'package:flutter/material.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class UserCreatePage extends StatefulWidget {
  const UserCreatePage({Key? key}) : super(key: key);

  @override
  State<UserCreatePage> createState() => _UserCreatePageState();
}

class _UserCreatePageState extends State<UserCreatePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController marketIdController = TextEditingController();
  bool isAdmin = false;
  bool isMarketOwner = false;
  bool isMarketStaff = true;

  String? nameErrorText;
  String? emailErrorText;
  String? passwordErrorText;
  String? marketIdErrorText;
  final UserClient userClient = UserClient();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    marketIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Yeni Kullanıcı Oluştur",
                  style: TextStyle(
                    color: Colors.purple.shade100,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Adı",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                          left: Radius.circular(10.0)),
                    ),
                    errorText: nameErrorText,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "E-posta Adresi",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                          left: Radius.circular(10.0)),
                    ),
                    errorText: emailErrorText,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                          left: Radius.circular(10.0)),
                    ),
                    errorText: passwordErrorText,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: marketIdController,
                  decoration: InputDecoration(
                    labelText: "Market ID",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                          left: Radius.circular(10.0)),
                    ),
                    errorText: marketIdErrorText,
                  ),
                ),
                const SizedBox(height: 10),
                CheckboxListTile(
                  title: const Text("Admin"),
                  value: isAdmin,
                  onChanged: (bool? value) {
                    setState(() {
                      isAdmin = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text("Market Sahibi"),
                  value: isMarketOwner,
                  onChanged: (bool? value) {
                    setState(() {
                      isMarketOwner = value ?? false;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text("Market Personeli"),
                  value: isMarketStaff,
                  onChanged: (bool? value) {
                    setState(() {
                      isMarketStaff = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 20),
             ElevatedButton(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
        Color.fromARGB(209, 162, 95, 189)),
  ),
  onPressed: () async {
    createUser();
  },
  child: const Text("OLUŞTUR"),
),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("KAPAT"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void createUser() async {
  nameErrorText = nameController.text.isEmpty
      ? 'Bu alanı doldurmak zorunludur.'
      : null;
  emailErrorText = emailController.text.isEmpty
      ? 'Bu alanı doldurmak zorunludur.'
      : null;
  passwordErrorText = passwordController.text.isEmpty
      ? 'Bu alanı doldurmak zorunludur.'
      : null;
  marketIdErrorText = marketIdController.text.isEmpty
      ? 'Bu alanı doldurmak zorunludur.'
      : null;

  if (nameErrorText == null &&
      emailErrorText == null &&
      passwordErrorText == null &&
      marketIdErrorText == null) {
    try {
      await userClient.userCreate(
        name: nameController.text,
        email: emailController.text,
        marketId: marketIdController.text,
        isAdmin: isAdmin,
        isMarketOwner: isMarketOwner,
        isMarketStaff: isMarketStaff,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Kullanıcı oluşturulurken bir hata oluştu: $e'),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lütfen tüm alanları doldurun.'),
      ),
    );
  }
}

}
