import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/users_model.dart';
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
  UserClient user = new UserClient();

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
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              loadMoreData();
            }
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: userModels.map((user) {
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
                                user.name ?? '',
                                style: GoogleFonts.getFont('Lato'),
                              ),
                              Text(
                                  user.market!.name ?? '',
                                  style: GoogleFonts.getFont('Lato',
                                      fontStyle: FontStyle.normal,
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400)),
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
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          spaceBetweenChildren: 10,
          children: [
            SpeedDialChild(
              child: Container(
              child:const Text("Yeni Kullanıcı Oluştur",style: TextStyle(color: Colors.deepPurple),),
              ),
              onTap: (){}),
            ],
        ),
      ),
    );
  }
}
