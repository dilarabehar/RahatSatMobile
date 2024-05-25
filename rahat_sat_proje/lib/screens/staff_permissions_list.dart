import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/staff_permissions_model.dart';
import 'package:rahat_sat_project/screens/staffPermission_update_page.dart';

class StaffPermissionListView extends StatefulWidget {
  final List<StaffPermissionsListing> inPermissions;

  const StaffPermissionListView({Key? key, required this.inPermissions})
      : super(key: key);

  @override
  State<StaffPermissionListView> createState() =>
      _StaffPermissionListViewState(inPermissions);
}

enum RadioButtonOptions { KDV, KarOrani }

const List<String> _list = <String>['One', 'Two', 'Three', 'Four'];

class _StaffPermissionListViewState extends State<StaffPermissionListView> {
  _StaffPermissionListViewState(inProducts);
  late List<StaffPermissionsListing> permissions = widget.inPermissions;
  RadioButtonOptions? _character = RadioButtonOptions.KDV;
  TextEditingController selectedValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Personel İzinleri"),
        ),
        body: SingleChildScrollView(
          child: Column(
              children: permissions.map((permission) {
            return Padding(
              padding: EdgeInsets.all(3),
              child: Card(
                elevation: 3,
                margin: EdgeInsets.all(8),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Row(
                    children: [
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Personel Adı: ${permission.user?.name ?? ''} ",
                              style: GoogleFonts.getFont('Lato'),
                            ),
                            Text(
                              "Ürünler: ${permission.readProducts == 1 ? "Tam Erişim" : "Yok"}  ",
                              style: GoogleFonts.getFont('Lato',
                                  fontStyle: FontStyle.normal,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400)),
                            ),
                            Text(
                              "Personel: ${permission.readStaff == 1 ? "Tam Erişim" : "Yok"}",
                              style: GoogleFonts.getFont('Lato',
                                  fontStyle: FontStyle.normal,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400)),
                            ),
                            Text(
                              "Satış: ${permission.cameraSale == 1 ? "Tam Erişim" : "Yok"}",
                              style: GoogleFonts.getFont('Lato',
                                  fontStyle: FontStyle.normal,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StaffPermissionUpdate(
                                    staffPermissions:
                                        StaffPermissionsModelPermissions(
                                            cameraSale: permission.cameraSale,
                                            readCategories:
                                                permission.readCategories,
                                            writeCategories:
                                                permission.writeCategories,
                                            writeProducts:
                                                permission.writeProducts,
                                            readProducts:
                                                permission.readProducts,
                                            writeStaff: permission.writeStaff,
                                            readStaff: permission.readStaff,
                                            userId: permission.userId)))),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList()),
        ),
      ),
    );
  }
}

                                        
// 7QSNTzh86EePCu3K
// admin@rahatsat.com