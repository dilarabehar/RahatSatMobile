import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/categories_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';

//productlar

class CategoriesListView extends StatefulWidget {
  final List<CategoriesModels> allCategories;

  const CategoriesListView({Key? key, required this.allCategories})
      : super(key: key);

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  late List<CategoriesModels> categories;
  int currentPage = 1; // Initial page
  UserClient userClient = UserClient();

  @override
  void initState() {
    super.initState();
    categories = widget.allCategories;
  }

  Future<void> loadMoreData() async {
    // Assuming your API supports pagination with query parameters like 'page'
    // Adjust your API request accordingly to fetch the next page
    var nextPage = currentPage + 1;

    // Fetch data for the next page
    var allData = await userClient.fetchCategoriesForPage(nextPage);

    // Update the UI with the new data
    setState(() {
      categories.addAll(allData as Iterable<CategoriesModels>);
      currentPage = nextPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Tüm Kategoriler"),
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
              children: categories.map((categories) {
                return Padding(
                  padding:const  EdgeInsets.all(3),
                  child: Card(
                    elevation: 3,
                    margin:const EdgeInsets.all(8),
                    child: ListTile(
                      contentPadding:const EdgeInsets.all(16),
                      title: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              categories.image as String,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  categories.name ?? '',
                                  style: GoogleFonts.getFont('Lato'),
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
                            icon:const Icon(Icons.edit),
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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(192, 91, 67, 196)),
                ),
                onPressed: () {},
                child: Text("Yeni Kategori Oluştur",
                    style: GoogleFonts.getFont('Lato',
                        fontStyle: FontStyle.normal,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ))),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(192, 91, 67, 196)),
                ),
                onPressed: () {},
                child: Text("CSV ile Aktar",
                    style: GoogleFonts.getFont('Lato',
                        fontStyle: FontStyle.normal,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
