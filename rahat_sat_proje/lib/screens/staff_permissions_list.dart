import 'package:flutter/material.dart';
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
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 40.0,
                            height: 40.0,
                            child: const Icon(Icons.person),
                          ),
                          const SizedBox(width:10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                permissions.user?.name ?? '',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text("Tam Erişim",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text("Düzenle"),
                          ),
                          const SizedBox(width: 5.0),
                        ],
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