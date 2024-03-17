import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                                  "Personel Adı: ${staff.name}" ?? '',
                                  style: GoogleFonts.getFont('Lato'),
                                ),
                                Text(
                                  "E-mail : ${staff.email}",
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
              }).toList(),
            ),
          ),
        ),
        floatingActionButton: Container(
          child:  ElevatedButton(
            style:  const ButtonStyle(backgroundColor:MaterialStatePropertyAll( Color.fromARGB(192, 91, 67, 196)),
            ),
            onPressed: () {},
            child: Text("Yeni Personel Oluştur",
            style: GoogleFonts.getFont('Lato',fontStyle: FontStyle.normal,textStyle: const TextStyle(color: Colors.white,))
            ),
          ),
        ),
      ),
    );
  }
}
