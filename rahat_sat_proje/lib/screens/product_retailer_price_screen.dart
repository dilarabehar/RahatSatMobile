import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/product_retailer_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';

//product retailer screen

class ProductRetailerPriceView extends StatefulWidget {
  final List<ProductRetailProductRetailPrices> inRetailerPrice;

  const ProductRetailerPriceView({Key? key, required this.inRetailerPrice}) : super(key: key);

  @override
  State<ProductRetailerPriceView> createState() => _ProductRetailerPriceViewState();
}

class _ProductRetailerPriceViewState extends State<ProductRetailerPriceView> {
  late List<ProductRetailProductRetailPrices> retailers;
  int currentPage = 1; // Initial page
  UserClient userClient = new UserClient();

  @override
  void initState() {
    super.initState();
    retailers = widget.inRetailerPrice;
  }

  Future<void> loadMoreData() async {
    var additionalData = await userClient.getAllProductRetailerPrices();
    setState(() {
      retailers.addAll(additionalData!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Ürün Tedarikçi Fiyatları"),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              // Reached the bottom of the list, load more data
              //deneme yorum
              //loadMoreData();
            }
            return false;
          },
          child: SingleChildScrollView(
            child: Column(
              children: retailers.map((retailer) {
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
                                retailer.product?.name ?? '',
                                style: GoogleFonts.getFont('Lato'),
                              ),
                             
                              Text(
                                  retailer.retailerName ?? '',
                                  style: GoogleFonts.getFont('Lato',
                                      fontStyle: FontStyle.normal,
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400)),
                                ),
                                 Text(
                                  retailer.price.toString(),
                                  style: GoogleFonts.getFont('Lato',
                                      fontStyle: FontStyle.normal,
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400)),
                                ),

                                 Text(
                                  retailer.dataDate ?? '',
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
              );}).toList(),
            ),
          ),
          
        ),
     floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          spaceBetweenChildren: 10,
          children: [
            SpeedDialChild(
              child: Container(
              child:const Text("Yeni Ürün Perakende Fiyatı Oluştur",style: TextStyle(color: Colors.deepPurple),),
              ),
              onTap: (){}),
            SpeedDialChild(
              child: Container(
              child:const Text("CSV ile Aktar",style: TextStyle(color: Colors.deepPurple),),
              ),
              onTap: (){})
          ],
        ),),
    );
  }
}
