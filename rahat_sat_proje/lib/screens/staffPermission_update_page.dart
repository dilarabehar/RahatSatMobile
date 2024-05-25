import 'package:flutter/material.dart';
import 'package:rahat_sat_project/model/staff_permissions_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class StaffPermissionUpdate extends StatefulWidget {
  final StaffPermissionsModelPermissions staffPermissions;
  const StaffPermissionUpdate({Key? key, required this.staffPermissions})
      : super(key: key);

  @override
  State<StaffPermissionUpdate> createState() => _StaffPermissionUpdateState();
}

enum RadioButtonOptions {
  productV,
  productU,
  staffV,
  staffU,
  camera,
  categoryU,
  categoryV
}

class _StaffPermissionUpdateState extends State<StaffPermissionUpdate> {
  final UserClient permissionsPatchService = UserClient();

  final Map<RadioButtonOptions, bool> _permissions = {
    RadioButtonOptions.productV: false,
    RadioButtonOptions.productU: false,
    RadioButtonOptions.staffV: false,
    RadioButtonOptions.staffU: false,
    RadioButtonOptions.camera: false,
    RadioButtonOptions.categoryU: false,
    RadioButtonOptions.categoryV: false
  };

  bool _productViewSelected = false;
  bool _staffViewSelected = false;

  @override
  void initState() {
    super.initState();
    _permissions[RadioButtonOptions.productV] =
        widget.staffPermissions.readProducts ==
            1; // ürünleri görüntüle  = false geldi permission listten
    _permissions[RadioButtonOptions.productU] =
        widget.staffPermissions.writeProducts == 1;
    _permissions[RadioButtonOptions.staffV] =
        widget.staffPermissions.readStaff == 1;
    _permissions[RadioButtonOptions.staffU] =
        widget.staffPermissions.writeStaff == 1;
    _permissions[RadioButtonOptions.camera] =
        widget.staffPermissions.cameraSale == 1;
    _permissions[RadioButtonOptions.categoryU] =
        widget.staffPermissions.writeCategories == 1;
    _permissions[RadioButtonOptions.categoryV] =
        widget.staffPermissions.readCategories == 1;

    _productViewSelected = _permissions[RadioButtonOptions.productV]!;
    _staffViewSelected = _permissions[RadioButtonOptions.staffV]!;
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
                  "Personel İzinleri Düzenle",
                  style: TextStyle(
                    color: Colors.purple.shade100,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: const Text("Ürünleri Görüntüle"),
                  value: _permissions[RadioButtonOptions.productV], //false
                  onChanged: (bool? value) {
                    setState(() {
                      _permissions[RadioButtonOptions.productV] = value!; //true
                      _productViewSelected =
                          value; // true /aktif ettim ürünleri düzenle butonu
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text("Ürünleri Düzenle"),
                  value: _permissions[RadioButtonOptions.productU],
                  onChanged: _productViewSelected //true
                      ? (value) {
                          setState(() {
                            _permissions[RadioButtonOptions.productU] = value!;
                          });
                        }
                      : null,
                ),
                CheckboxListTile(
                  title: const Text("Personeli Görüntüle"),
                  value: _permissions[RadioButtonOptions.staffV],
                  onChanged: (value) {
                    setState(() {
                      _permissions[RadioButtonOptions.staffV] = value!;
                      _staffViewSelected = value;
                    });
                  },
                ),
                CheckboxListTile(
                    title: const Text("Personeli Düzenle"),
                    value: _permissions[RadioButtonOptions.staffU],
                    onChanged: _staffViewSelected
                        ? (bool? value) {
                            setState(() {
                              _permissions[RadioButtonOptions.staffU] = value!;
                            });
                          }
                        : null),
                CheckboxListTile(
                  title: const Text("Kamera Satış Ekranı"),
                  value: _permissions[RadioButtonOptions.camera],
                  onChanged: (value) {
                    setState(() {
                      _permissions[RadioButtonOptions.camera] = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await permissionsPatchService.updateStaffPermissions(
                        widget.staffPermissions.userId!,
                        widget.staffPermissions.readCategories as bool,
                        widget.staffPermissions.readProducts as bool,
                        widget.staffPermissions.readStaff as bool,
                        widget.staffPermissions.writeCategories as bool,
                        widget.staffPermissions.writeProducts as bool,
                        widget.staffPermissions.cameraSale as bool,
                        widget.staffPermissions.writeStaff as bool,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Personel güncellenirken bir hata oluştu: $e'),
                        ),
                      );
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
