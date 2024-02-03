import 'package:flutter/material.dart';
import 'package:rahat_sat_project/model/staff_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';

//productlar

class StaffListView extends StatefulWidget {
  final List<StaffListing> inStaffList;

  const StaffListView({Key? key, required this.inStaffList}) : super(key: key);

  @override
  State<StaffListView> createState() => _StaffListViewState();
}

class _StaffListViewState extends State<StaffListView> {
  late List<StaffListing> staffs;
  int currentPage = 1; // Initial page
  UserClient userClient = new UserClient();

  @override
  void initState() {
    super.initState();
    staffs = widget.inStaffList;
  }

  Future<void> loadMoreData() async {
    var additionalData = await userClient.getAllStaff();
    setState(() {
      staffs.addAll(additionalData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Personeller"),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              // Reached the bottom of the list, load more data
              //deneme yorum
              loadMoreData();
            }
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: staffs.map((staff) {
                return Padding(
                  padding: EdgeInsets.all(3),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
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
                                width: 40,
                                height: 40.0,
                               // color: Colors.deepPurple,
                                child: const Icon(Icons.person
                                 ),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    staff.name ?? '',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    staff.email ?? '',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Düzenle"),
                              ),
                              const SizedBox(height: 2.0),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Sil"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
        ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.deepPurple,onPressed: (){},child: Icon(Icons.group_add),tooltip: "Yeni Personel Oluştur",)),
    );
  }
}
