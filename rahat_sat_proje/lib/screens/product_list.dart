import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
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
          title: const Text("Tüm Ürünler"),
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
              children: products.map((product) {
                return Padding(
                padding: EdgeInsets.all(3),
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: Image.network(
                            product.image as String ??
                                "https://www.alleycat.org/wp-content/uploads/2019/03/FELV-cat.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name ?? '',
                                style: GoogleFonts.getFont('Lato'),
                              ),
                              Text(
                                  product.category.name,
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
         floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          spaceBetweenChildren: 10,
          children: [
            SpeedDialChild(
              child: Container(
              child:const Text("Yeni Ürün Oluştur",style: TextStyle(color: Colors.deepPurple),),
              ),
              onTap: (){}),
            SpeedDialChild(
              child: Container(
              child:const Text("CSV ile Aktar",style: TextStyle(color: Colors.deepPurple),),
              ),
              onTap: (){})
          ],
        ),
      ),
    );
  }
}
