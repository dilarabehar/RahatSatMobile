import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';
import 'package:super_bullet_list/bullet_list.dart';

//productlar

class SalesListView extends StatefulWidget {
  final List<SoldListing> allSoldProducts;

  const SalesListView({Key? key, required this.allSoldProducts})
      : super(key: key);

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
                              product.product?.image ??
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
                                  product.product?.name ?? '',
                                  style: GoogleFonts.getFont('Lato'),
                                ),
                                SuperBulletList(
                                    isOrdered: false,
                                    gap: 4,
                                    items: [
                                      Text(
                                        'Ürün Miktarı: ${product.unitCost}',
                                        style: GoogleFonts.getFont('Lato',
                                            fontStyle: FontStyle.normal,
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      Text(
                                        'Birim Maliyeti: ${product.unitCost} TL',
                                        style: GoogleFonts.getFont('Lato',
                                            fontStyle: FontStyle.normal,
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      Text(
                                        'KDV Oranı (%): ${product.taxRate}',
                                        style: GoogleFonts.getFont('Lato',
                                            fontStyle: FontStyle.normal,
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      Text(
                                        'Kar Oranı (%): ${product.profitRate}',
                                        style: GoogleFonts.getFont('Lato',
                                            fontStyle: FontStyle.normal,
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      Text(
                                        'Toplam Fiyat: ${product.totalPrice} TL',
                                        style: GoogleFonts.getFont('Lato',
                                            fontStyle: FontStyle.normal,
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      Text(
                                        'Tarih: ${product.updatedAt}',
                                        style: GoogleFonts.getFont('Lato',
                                            fontStyle: FontStyle.normal,
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ]),
                              ],
                            ),
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
