import 'package:flutter/material.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class ProductRequestForm extends StatefulWidget {
  @override
  _ProductRequestFormState createState() => _ProductRequestFormState();
}

class _ProductRequestFormState extends State<ProductRequestForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController productNameController;
  late TextEditingController productBarcodeController;
  late TextEditingController messageController;

  String? nameErrorText;
  String? barcodeErrorText;
  String? messageErrorText;

  final UserClient productReq = UserClient();

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController();
    productBarcodeController = TextEditingController();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    productNameController.dispose();
    productBarcodeController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<void> _submitRequest() async {
    setState(() {
      nameErrorText = productNameController.text.isEmpty
          ? 'Bu alanı doldurmak zorunludur.'
          : null;
      barcodeErrorText = productBarcodeController.text.isEmpty
          ? 'Bu alanı doldurmak zorunludur.'
          : null;
      messageErrorText = messageController.text.isEmpty
          ? 'Bu alanı doldurmak zorunludur.'
          : null;
    });

    if (nameErrorText == null &&
        barcodeErrorText == null &&
        messageErrorText == null) {
      try {
        await productReq.newProductRequest(
          productNameController.text,
          productBarcodeController.text,
          messageController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ürün talebiniz başarıyla oluşturuldu.'),
          ),
        );
        
        // Ürün talebi başarıyla oluşturulduktan sonra ana sayfaya dön
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ürün talebi yapılırken bir hata oluştu: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ürün Talebi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Ürün Talebi",
                    style: TextStyle(
                      color: Colors.purple.shade100,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(
                      labelText: "Ürün Adı",
                      border: const OutlineInputBorder(),
                      errorText: nameErrorText,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bu alanı doldurmak zorunludur.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: productBarcodeController,
                    decoration: InputDecoration(
                      labelText: "Ürün Barkodu",
                      border: const OutlineInputBorder(),
                      errorText: barcodeErrorText,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bu alanı doldurmak zorunludur.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      labelText: "Mesaj",
                      border: const OutlineInputBorder(),
                      errorText: messageErrorText,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bu alanı doldurmak zorunludur.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitRequest, // Değişiklik yapıldı
                    child: const Text("GÖNDER"),
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
      ),
    );
  }
}
