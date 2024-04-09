import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:super_bullet_list/bullet_list.dart';

class ProductSoldView2 extends StatefulWidget {
  final List<SoldListing> inProducts;

  const ProductSoldView2({Key? key, required this.inProducts})
      : super(key: key);

  @override
  State<ProductSoldView2> createState() => _ProductSoldView2State();
}

class _ProductSoldView2State extends State<ProductSoldView2> {
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
                          child: Image.asset(
                            product.product?.image as String ??
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1599px-Cat_poster_1.jpg",
                            fit: BoxFit.cover,
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
      ),
    );
  }
}


// SATILAN ESKİ
/*
import 'package:flutter/material.dart';
import 'package:rahat_sat_project/model/product_model.dart';

//satılan

class ProductSoldView extends StatefulWidget {
  final List<SoldListing> inProducts;
  
  const ProductSoldView({Key? key, required this.inProducts}):super(key: key);

  @override
  State<ProductSoldView> createState() => _ProductSoldViewState(inProducts);
}

class _ProductSoldViewState extends State<ProductSoldView> {

_ProductSoldViewState(inProducts);
late List<SoldListing> products = widget.inProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Satılan Ürünler"),
        ),
        body: SingleChildScrollView(child:
        Column(children: products.map((product){
          return Padding(padding: EdgeInsets.all(3),
          child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
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
                      child: CircleAvatar(backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.deepPurple,
                      backgroundImage: NetworkImage(product.product?.image as String ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1599px-Cat_poster_1.jpg' ),
                      ) ,
                    ),
                    const SizedBox(width: 5.0),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(product.product?.name ?? '',style: const TextStyle(color: Colors.black,fontSize:18.0,fontWeight: FontWeight.bold ),),
                          Text(product.product?.categoryId ?? '',style: TextStyle(color: Colors.grey),),
                          Text(product.product?.barcode ?? '',style: TextStyle(color: Colors.grey),),
                          Text(product.stockCount.toString() ?? '',style: TextStyle(color: Colors.grey),),

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
                  ),],),
                  ],
                ),
                
              ),
            ),);
        }).toList()),),
      ),
    );
  }
}
*/