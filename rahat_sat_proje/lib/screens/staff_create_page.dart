import 'package:flutter/material.dart';
import 'package:rahat_sat_project/model/staff_model.dart';
import 'package:rahat_sat_project/services/staff_post_service.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class StaffCreatePage extends StatefulWidget {
  const StaffCreatePage({Key? key}) : super(key: key);

  @override
  State<StaffCreatePage> createState() => _StaffCreatePageState();
}

class _StaffCreatePageState extends State<StaffCreatePage> {

  final TextEditingController staffNameController = TextEditingController();
  final TextEditingController staffMailController = TextEditingController();
  final TextEditingController staffPasswordController = TextEditingController();

  String? nameErrorText;
  String? mailErrorText;
  String? passwordErrorText;
  final UserClient staffPostService = UserClient();

  @override
  void dispose() {
    staffNameController.dispose();
    staffMailController.dispose();
    staffPasswordController.dispose();
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
                  "Yeni Personel Oluştur",
                  style: TextStyle(
                    color: Colors.purple.shade100,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: staffNameController,
                  decoration: InputDecoration(
                    labelText: "Personel Adı",
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
                  controller: staffMailController,
                  decoration: InputDecoration(
                    labelText: "E-posta Adresi",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                          left: Radius.circular(10.0)),
                    ),
                    errorText: mailErrorText,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: staffPasswordController,
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
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(209, 162, 95, 189)),
                  ),
                  onPressed: () async {
                    setState(() {
                      nameErrorText = staffNameController.text.isEmpty
                          ? 'Bu alanı doldurmak zorunludur.'
                          : null;
                      mailErrorText = staffMailController.text.isEmpty
                          ? 'Bu alanı doldurmak zorunludur.'
                          : null;
                      passwordErrorText = staffPasswordController.text.isEmpty
                          ? 'Bu alanı doldurmak zorunludur.'
                          : null;

                      if (nameErrorText == null &&
                          mailErrorText == null &&
                          passwordErrorText == null) {
                        final service = staffPostService.createStaff(staffNameController.text,
                            staffMailController.text,
                            staffPasswordController.text);
                       
                        createStaffRequest(
                            staffNameController.text,
                            staffMailController.text,
                            staffPasswordController.text);
                      }
                    });
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
// burası daha sonra silinebilir console işlemi için yazdım 
  void createStaffRequest(String name, String email, String password) {
    String staffName = staffNameController.text;
    String staffMail = staffMailController.text;
    String? staffPassword = staffPasswordController.text;

    print("Personel Adı: $staffName");
    print("E-posta Adresi: $staffMail");
    print("Şifre: $staffPassword");

    Navigator.pop(context);

    /*  Future.delayed(const Duration(seconds: 1));
    staffPostService.createStaff(name, email, password).then((response) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("hele hele hebele"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    });*/
  }
}
