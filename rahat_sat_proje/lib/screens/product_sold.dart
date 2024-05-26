import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:rahat_sat_project/screens/product_edits_page.dart';
import 'package:rahat_sat_project/screens/product_listings_create.dart';
import 'package:rahat_sat_project/screens/rate_update_page.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class ProductSoldView extends StatefulWidget {
  final List<SoldListing> inProducts;

  const ProductSoldView({Key? key, required this.inProducts}) : super(key: key);

  @override
  State<ProductSoldView> createState() => _ProductSoldViewState();
}

class _ProductSoldViewState extends State<ProductSoldView> {
  late List<SoldListing> products;
  late UserClient userClient = new UserClient();
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
                            "https://uygulama.rahatsat.com/productImages/8690526095264.jpeg",
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
                              const SizedBox(height: 3),
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
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductsEdit(inSoldListing: product))),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            // Silme işlemini onaylamak için bir alert göster
                            bool deleteConfirmed = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Ürün Satışını Sil'),
                                content: Text(
                                    'Ürün satışını silmek istediğinizden emin misiniz?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: Text('İptal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: Text('Sil'),
                                  ),
                                ],
                              ),
                            );

                            if (deleteConfirmed) {
                              try {
                                await userClient.deleteSoldProduct(product.id!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: const Text(
                                          'Satılan ürün başarıyla silindi')),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Ürün silinirken bir hata oluştu: $e')),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
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
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductListingCreate())),
                child: Text("Yeni Ürün Sat",
                    style: GoogleFonts.getFont('Lato',
                        fontStyle: FontStyle.normal,
                        fontSize: 15,
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RateUpdate()));
                },
                child: Text("Oranları Güncelle",
                    style: GoogleFonts.getFont('Lato',
                        fontStyle: FontStyle.normal,
                        fontSize: 15,
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
// 7QSNTzh86EePCu3K
// admin@rahatsat.com
