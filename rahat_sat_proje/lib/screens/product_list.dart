import 'package:flutter/material.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';


//productlar

class ProductListView extends StatefulWidget {
  final List<ProductListing> inProductsList;

  const ProductListView({Key? key, required this.inProductsList}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late List<ProductListing> products;
  int currentPage = 1; // Initial page
  UserClient user = new UserClient();

  @override

    void initState() {
    super.initState();
    products = widget.inProductsList;
  }

  Future<void> loadMoreData() async {
    // Assuming your API supports pagination with query parameters like 'page'
    // Adjust your API request accordingly to fetch the next page
    var nextPage = currentPage + 1;

    // Fetch data for the next page
    var additionalData = await user.fetchDataForPage(nextPage);

    // Update the UI with the new data
    setState(() {
      products.addAll(additionalData);
      currentPage = nextPage;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Satılan Ürünler"),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              // Reached the bottom of the list, load more data
              loadMoreData();
            }
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: products.map((product) {
                return Padding(
                  padding: EdgeInsets.all(3),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                                child: CircleAvatar(
                                  backgroundColor: Colors.deepPurple,
                                  foregroundColor: Colors.deepPurple,
                                  backgroundImage: NetworkImage(
                                      product.image as String ??
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1599px-Cat_poster_1.jpg'),
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    product.name ?? '',
                                    style: const TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    product.categoryId ?? '',
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
