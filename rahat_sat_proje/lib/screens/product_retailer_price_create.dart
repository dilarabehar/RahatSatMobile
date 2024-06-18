import 'package:flutter/material.dart';
import 'package:rahat_sat_project/services/product_service.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class ProductRetailPriceCreatePage extends StatefulWidget {
  const ProductRetailPriceCreatePage({Key? key}) : super(key: key);

  @override
  _ProductRetailPriceCreatePageState createState() =>
      _ProductRetailPriceCreatePageState();
}

class _ProductRetailPriceCreatePageState
    extends State<ProductRetailPriceCreatePage> {
  late TextEditingController productIdController;
  late TextEditingController retailerNameController;
  late TextEditingController priceController;
  late TextEditingController dataDateController;
  final UserClient productService = UserClient();

  @override
  void initState() {
    super.initState();
    productIdController = TextEditingController();
    retailerNameController = TextEditingController();
    priceController = TextEditingController();
    dataDateController = TextEditingController();
  }

  @override
  void dispose() {
    productIdController.dispose();
    retailerNameController.dispose();
    priceController.dispose();
    dataDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Yeni Ürün Perakende Fiyatı Oluştur",
                  style: TextStyle(
                    color: Color.fromARGB(255, 134, 44, 150),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: productIdController,
                  decoration: const InputDecoration(
                    labelText: "Ürün ID",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: retailerNameController,
                  decoration: const InputDecoration(
                    labelText: "Perakende Satıcı Adı",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: "Fiyat",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dataDateController,
                  decoration: const InputDecoration(
                    labelText: "Tarih",
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        dataDateController.text =
                            pickedDate.toString(); // veya istediğiniz biçimde dönüştürün
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(209, 162, 95, 189)),
                  ),
                  onPressed: () async {
                    try {
                      await productService.createProductRetailPrice(
                        productId: productIdController.text,
                        retailerName: retailerNameController.text,
                        price: double.parse(priceController.text),
                        dataDate: DateTime.parse(dataDateController.text),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Ürün perakende fiyatı başarıyla oluşturuldu"),
                        ),
                      );
                      // Fiyat başarıyla oluşturulduktan sonra navigasyon işlemleri yapılabilir
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Ürün perakende fiyatı oluşturulurken bir hata oluştu: $error"),
                        ),
                      );
                    }
                  },
                  child: const Text("OLUŞTUR"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("KAPAT"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
