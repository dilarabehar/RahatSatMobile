import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:super_bullet_list/bullet_list.dart';

class ProductSoldView extends StatefulWidget {
  final List<SoldListing> inProducts;

  const ProductSoldView({Key? key, required this.inProducts})
      : super(key: key);

  @override
  State<ProductSoldView> createState() => _ProductSoldViewState();
}

class _ProductSoldViewState extends State<ProductSoldView> {
  late List<SoldListing> products;
  @override
  void initState() {
    super.initState();
    products = widget.inProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Satılan Ürünler"),
        ),
        body: SingleChildScrollView(
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
                            product.product?.image as String ??
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
                              SuperBulletList(isOrdered: false, gap: 4, items: [
                                Text(
                                  'Stok Miktarı: ${product.stockCount}',
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
                              ]),
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
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          spaceBetweenChildren: 10,
          children: [
            SpeedDialChild(
              child: Container(
              child:const Text("Yeni Ürün Sat",style: TextStyle(color: Colors.deepPurple),),
              ),
              onTap: (){}),
            SpeedDialChild(
              child: Container(
              child:const Text("Oranları Güncelle",style: TextStyle(color: Colors.deepPurple),),
              ),
              onTap: (){})
          ],
        ),
      ),
    );
  }
}
// 7QSNTzh86EePCu3K
// admin@rahatsat.com
