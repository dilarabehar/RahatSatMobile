import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/product_requests_model.dart';
import 'package:rahat_sat_project/screens/product_request_create.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class ProductRequestView extends StatefulWidget {
  final List<ProductRequest> inRequestsList;

  const ProductRequestView({Key? key, required this.inRequestsList}) : super(key: key);

  @override
  State<ProductRequestView> createState() => _ProductRequestViewState();
}

class _ProductRequestViewState extends State<ProductRequestView> {
  late List<ProductRequest> requests;
  int currentPage = 1; // Initial page
  UserClient userClient = UserClient();

  @override
  void initState() {
    super.initState();
    requests = widget.inRequestsList;
  }

  Future<void> loadMoreData() async {
    var additionalData = await userClient.getProductsRequests();
    setState(() {
      requests.addAll(additionalData!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Ürün Talepleri"),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels ==
              scrollInfo.metrics.maxScrollExtent) {
            // Reached the bottom of the list, load more data
            loadMoreData();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: requests.length,
          itemBuilder: (BuildContext context, int index) {
            ProductRequest request = requests[index];
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
                              request.id ?? '',
                              style: GoogleFonts.getFont('Lato'),
                            ),
                            Text(
                              request.marketid ?? '',
                              style: GoogleFonts.getFont('Lato',
                                  fontStyle: FontStyle.normal,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400)),
                            ),
                            Text(
                              request.productname ?? '',
                              style: GoogleFonts.getFont('Lato'),
                            ),
                            Text(
                              request.productbarcode ?? '',
                              style: GoogleFonts.getFont('Lato',
                                  fontStyle: FontStyle.normal,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400)),
                            ),
                            Text(
                              request.message ?? '',
                              style: GoogleFonts.getFont('Lato',
                                  fontStyle: FontStyle.normal,
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400)),
                            ),
                            Text(
                              request.createdat ?? '',
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
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          // ProductRequestForm'a yönlendirme
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductRequestForm()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: "Ürün Talebi Oluştur",
      ),
    );
  }
}
