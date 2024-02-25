import 'package:flutter/material.dart';
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
                  padding: const EdgeInsets.all(3),
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
                                width: 40.0,
                                height: 40.0,
                                color: Colors.deepPurple,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.deepPurple,
                                  foregroundColor: Colors.deepPurple,
                                  backgroundImage: NetworkImage(
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1599px-Cat_poster_1.jpg'),
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    user.name ?? '',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    user.email ?? '',
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
                              const SizedBox(width: 5.0),
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
      ),
    );
  }
}
