import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/users_model.dart';
import 'package:rahat_sat_project/screens/users_list_create.dart';
import 'package:rahat_sat_project/services/user_client.dart';

// ALL USERS
class UsersListView extends StatefulWidget {
  final List<UsersModelsListing> allUserList;

  const UsersListView({Key? key, required this.allUserList}) : super(key: key);

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  late List<UsersModelsListing> userModels;
  int currentPage = 1;
  UserClient user = UserClient();

  @override
  void initState() {
    super.initState();
    userModels = widget.allUserList;
  }

  Future<void> loadMoreData() async {
    var allUsersData = await user.getAllUsers();
    setState(() {
      userModels.addAll(allUsersData);
    });
  }

  Widget getRoleIcon(int? role) {
    switch (role) {
      case 0:
        return Text("Admin");
      case 1:
        return Text("Market Sahibi");
      case 2:
        return Text("Market Personeli");
      default:
        return Text("Bilinmeyen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Tüm Kullanıcılar"),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              loadMoreData();
            }
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: userModels.map((user) {
                return Padding(
                  padding: const EdgeInsets.all(3),
                  child: Card(
                    elevation: 3,
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Row(
                        children: [
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name ?? '',
                                  style: GoogleFonts.getFont('Lato'),
                                ),
                                Text(
                                  user.market!.name ?? '',
                                  style: GoogleFonts.getFont(
                                    'Lato',
                                    fontStyle: FontStyle.normal,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                getRoleIcon(user.isMarketStaff),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
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
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color.fromARGB(192, 91, 67, 196)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserCreatePage()),
              );
            },
            child: Text(
              "Yeni Kullanıcı Oluştur",
              style: GoogleFonts.getFont(
                'Lato',
                fontStyle: FontStyle.normal,
                textStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
