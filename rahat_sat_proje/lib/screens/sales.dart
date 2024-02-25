import 'package:flutter/material.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';

//productlar

class SalesListView extends StatefulWidget {
  final List<SoldListing> allSoldProducts;

  const SalesListView({Key? key, required this.allSoldProducts}) : super(key: key);

  @override
  State<SalesListView> createState() => _SalesListViewState();
}

class _SalesListViewState extends State<SalesListView> {
  late List<SoldListing> products;
  int currentPage = 1; // Initial page
  UserClient userClient = new UserClient();

  @override
  void initState() {
    super.initState();
    products = widget.allSoldProducts;
  }

  Future<void> loadMoreData() async {
    var additionalData = await userClient.getProduct();
    setState(() {
      products.addAll(additionalData!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Satışlar"),
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
                                child: const Icon(Icons.person),
                              ),
                              const SizedBox(width: 10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    product.product?.name ?? '',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    product.product?.barcode ?? '',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    product.product?.categoryId ?? '',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    product.stockCount.toString() ?? '',
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
