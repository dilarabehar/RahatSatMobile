import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MarketCreatePage extends StatefulWidget {
  const MarketCreatePage({Key? key}) : super(key: key);

  @override
  State<MarketCreatePage> createState() => _MarketCreatePageState();
}

class _MarketCreatePageState extends State<MarketCreatePage> {
  late TextEditingController marketNameController;
  late TextEditingController marketAddressController;
  File? _image;

  @override
  void initState() {
    super.initState();
    marketNameController = TextEditingController();
    marketAddressController = TextEditingController();
  }

  @override
  void dispose() {
    marketNameController.dispose();
    marketAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Yeni Market Oluştur",
                  style: TextStyle(
                    color: Colors.purple.shade100,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: marketNameController,
                  decoration: const InputDecoration(
                    labelText: "Market Adı",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                          left: Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: marketAddressController,
                  decoration: const InputDecoration(
                    labelText: "Market Adresi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                          left: Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(10.0),
                          left: Radius.circular(10.0)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.file_upload, size: 18),
                        SizedBox(width: 5),
                        Text(
                          _image == null
                              ? "Dosya Seç"
                              : _image!.path.split('/').last,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(209, 162, 95, 189)),
                  ),
                  onPressed: () {
                    createMarketRequest();
                  },
                  child: Text("OLUŞTUR"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("KAPAT"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    // Resim seçme işlevselliği
    // Kullanıcı galeriden resim seçiyor
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    // Kullanıcı resim seçtiyse ve dosya null değilse
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Seçilen resmi _image değişkenine ata
      });
    }
  }

  void createMarketRequest() {
    // Burada MarketService sınıfını kullanarak bir POST isteği gönderebilirsiniz
    String marketName = marketNameController.text;
    String marketAddress = marketAddressController.text;
    String? marketImage = _image?.path; // Market resmini al

    // Örnek olarak konsola yazdırabiliriz
    print("Market Adı: $marketName");
    print("Market Adresi: $marketAddress");
    print("Market Resmi: $marketImage");
  }
}
