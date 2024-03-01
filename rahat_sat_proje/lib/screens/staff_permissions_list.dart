import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/staff_permissions_model.dart';

class StaffPermissionListView extends StatefulWidget {
  final List<StaffPermissionsListing> inPermissions;

  const StaffPermissionListView({Key? key, required this.inPermissions})
      : super(key: key);

  @override
  State<StaffPermissionListView> createState() =>
      _StaffPermissionListViewState(inPermissions);
}

class _StaffPermissionListViewState extends State<StaffPermissionListView> {
  _StaffPermissionListViewState(inProducts);
  late List<StaffPermissionsListing> permissions = widget.inPermissions;

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
              children: permissions.map((permissions) {
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
                                permissions.user?.name ?? '',
                                style: GoogleFonts.getFont('Lato'),
                              ),
                              Text(
                                  "Tam Erişim",
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
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {},
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

//                                  7QSNTzh86EePCu3K
//          admin@rahatsat.com