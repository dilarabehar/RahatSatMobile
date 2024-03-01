import 'package:flutter/material.dart';

void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ürün Listesi'),
        ),
        body: ProductList2(),
      ),
    );
  }
}

class ProductList2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        Product product = products[index];

        return Card(
          elevation: 3,
          margin: EdgeInsets.all(8),
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text('Stok: ${product.stockQuantity}'),
                SizedBox(height: 8),
                Text('Birim Maliyet: \$${product.unitCost.toStringAsFixed(2)}'),
                SizedBox(height: 8),
                Text('KDV Oranı: ${product.taxRate * 100}%'),
                SizedBox(height: 8),
                Text('Kar Oranı: ${product.profitMargin * 100}%'),
                SizedBox(height: 8),
                Text('Toplam Fiyat: \$${calculateTotalPrice(product).toStringAsFixed(2)}'),
              ],
            ),
            leading: Image.asset(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Düzenleme işlemleri buraya eklenebilir.
                    // Örneğin, Navigator ile düzenleme sayfasına yönlendirme yapabilirsiniz.
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Silme işlemleri buraya eklenebilir.
                    // Örneğin, bir onay dialogu gösterip sonra ürünü listeden kaldırabilirsiniz.
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  double calculateTotalPrice(Product product) {
    return (product.unitCost + product.unitCost * product.taxRate) * (1 + product.profitMargin);
  }
}

class Product {
  final String name;
  final String image;
  final int stockQuantity;
  final double unitCost;
  final double taxRate;
  final double profitMargin;

  Product({
    required this.name,
    required this.image,
    required this.stockQuantity,
    required this.unitCost,
    required this.taxRate,
    required this.profitMargin,
  });
}

List<Product> products = [
  Product(
    name: "Ürün 1",
    image: "resim1.jpg",
    stockQuantity: 50,
    unitCost: 10.0,
    taxRate: 0.18,
    profitMargin: 0.2,
  ),
  Product(
    name: "Ürün 2",
    image: "resim2.jpg",
    stockQuantity: 30,
    unitCost: 15.0,
    taxRate: 0.18,
    profitMargin: 0.25,
  ),
  // Diğer ürünler...
];
