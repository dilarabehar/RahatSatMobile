import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class ProductCreatePage extends StatefulWidget {
  const ProductCreatePage({Key? key}) : super(key: key);

  @override
  _ProductCreatePageState createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  late TextEditingController productNameController;
  late TextEditingController productBarcodeController;
  File? _image;
  UserClient product = UserClient();


  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController();
    productBarcodeController = TextEditingController();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productBarcodeController.dispose();
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
                  "Yeni Ürün Oluştur",
                  style: TextStyle(
                    color: Color.fromARGB(255, 134, 44, 150),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: productNameController,
                  decoration: const InputDecoration(
                    labelText: "Ürün Adı",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                          left: Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: productBarcodeController,
                  decoration: const InputDecoration(
                    labelText: "Ürün Barkodu",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                          left: Radius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                          left: Radius.circular(10.0)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.file_upload, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          _image == null
                              ? "Resim Seç"
                              : _image!.path.split('/').last,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(209, 162, 95, 189)),
                  ),
                  onPressed: () async {
    try {
      await product.createProduct(
        productCategoryId: null, // Buraya kategori ID'si ekleyebilirsiniz
        productName: productNameController.text,
        productBarcode: productBarcodeController.text.isEmpty
            ? null
            : productBarcodeController.text,
        productImage: _image,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ürün başarıyla oluşturuldu"),
        ),
      );
      // Ürün başarıyla oluşturulduktan sonra navigasyon işlemleri yapılabilir
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ürün oluşturulurken bir hata oluştu: $error"),
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

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
