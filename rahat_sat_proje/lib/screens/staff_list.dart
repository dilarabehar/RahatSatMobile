import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/staff_model.dart';
import 'package:rahat_sat_project/screens/staff_create_page.dart';
import 'package:rahat_sat_project/screens/staff_update_page.dart';
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
                                  "Personel Adı: ${staff.name}",
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
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => StaffUpdatePage(
                                            staff: staff,
                                          ))))),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                // Silme işlemini onaylamak için bir alert göster
                                bool deleteConfirmed = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Personeli Sil'),
                                    content: Text(
                                        'Personeli silmek istediğinizden emin misiniz?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context,
                                              false); // İşlemi iptal et
                                        },
                                        child: Text('İptal'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context,
                                              true); // Silme işlemine devam et
                                        },
                                        child: Text('Sil'),
                                      ),
                                    ],
                                  ),
                                );

                                if (deleteConfirmed) {
                                  // Silme işlemi onaylandı, staff'i sil
                                  try {
                                    await userClient.deleteStaff(staff.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: const Text(
                                              'Personel başarıyla silindi')),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Personel silinirken bir hata oluştu: $e')),
                                    );
                                  }
                                }
                              }),
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
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(192, 91, 67, 196)),
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StaffCreatePage())),
            child: Text("Yeni Personel Oluştur",
                style: GoogleFonts.getFont('Lato',
                    fontStyle: FontStyle.normal,
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ))),
          ),
        ),
      ),
    );
  }
}
