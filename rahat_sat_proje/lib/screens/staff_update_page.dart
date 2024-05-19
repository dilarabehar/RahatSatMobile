import 'package:flutter/material.dart';
import 'package:rahat_sat_project/model/staff_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class StaffUpdatePage extends StatefulWidget {
  final StaffListing staff;

  const StaffUpdatePage({Key? key, required this.staff}) : super(key: key);

  @override
  State<StaffUpdatePage> createState() => _StaffUpdatePageState();
}

class _StaffUpdatePageState extends State<StaffUpdatePage> {
  late TextEditingController staffNameController;
  late TextEditingController staffMailController;
  late TextEditingController staffPasswordController;

  String? nameErrorText;
  String? mailErrorText;
  String? passwordErrorText;

  final UserClient staffPatchService = UserClient();

  @override
  void initState() {
    super.initState();
    staffNameController = TextEditingController(text: widget.staff.name);
    staffMailController = TextEditingController(text: widget.staff.email);
    staffPasswordController = TextEditingController();
  }

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
                  "Personel Düzenle",
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
                    border: const OutlineInputBorder(),
                    errorText: nameErrorText,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: staffMailController,
                  decoration: InputDecoration(
                    labelText: "E-posta Adresi",
                    border: const OutlineInputBorder(),
                    errorText: mailErrorText,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: staffPasswordController,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    border: const OutlineInputBorder(),
                    errorText: passwordErrorText,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
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
                    });

                    if (nameErrorText == null &&
                        mailErrorText == null &&
                        passwordErrorText == null) {
                      try {
                        await staffPatchService.updateStaff(
                          widget.staff.id,
                          staffNameController.text,
                          staffMailController.text,
                          staffPasswordController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Personel başarıyla güncellendi'),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Personel güncellenirken bir hata oluştu: $e'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("GÜNCELLE"),
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
}
