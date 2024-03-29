import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductsEdit extends StatefulWidget {
  const ProductsEdit({super.key});

  @override
  State<ProductsEdit> createState() => _ProductsEditState();
}

enum RadioButtonOptions { birimMaliyet, toplamFiyat, karOrani }

class _ProductsEditState extends State<ProductsEdit> {
 
  RadioButtonOptions? _character = RadioButtonOptions.birimMaliyet;
  
  TextEditingController kdvOrani = TextEditingController();
  TextEditingController urunStokMiktariController = TextEditingController();
  TextEditingController urunBirimMaliyetController = TextEditingController();
  TextEditingController karOraniController = TextEditingController();
  TextEditingController urunToplamFiyatController = TextEditingController();
  
  bool disableUrunStokMiktari = false;
  bool disableUrunBirimMaliyet = false;
  bool disableKDV = false;
  bool disableKarOrani = false;
  bool disableUrunToplamFiyat = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 10),
                child: Text("Ürünü Düzenle",
                    style:
                        TextStyle(color: Colors.purple.shade100, fontSize: 20)),
              )),
          const SizedBox(height: 5),
          ListTile(
            title: const Text("Birim Maliyetten Hesapla"),
            leading: Radio<RadioButtonOptions>(
                value: RadioButtonOptions.birimMaliyet,
                groupValue: _character,
                onChanged: (RadioButtonOptions? value) {
                  setState(() {
                    _character = value;
                    disableUrunStokMiktari = true;
                    disableUrunBirimMaliyet = true;
                    disableKDV = true;
                    disableKarOrani = true;
                    disableUrunToplamFiyat = false;
                  });
                }),
          ),
          ListTile(
            title: Text("Toplam Fiyattan Hesapla"),
            leading: Radio<RadioButtonOptions>(
                value: RadioButtonOptions.toplamFiyat,
                groupValue: _character,
                onChanged: (RadioButtonOptions? value) {
                  setState(() {
                    _character = value;
                    disableUrunStokMiktari = false;
                    disableUrunBirimMaliyet = true;
                    disableKDV = false;
                    disableKarOrani = false;
                    disableUrunToplamFiyat = false;
                  });
                }),
          ),
          ListTile(
            title: Text("Kar Oranı Hesapla (%)"),
            leading: Radio<RadioButtonOptions>(
                value: RadioButtonOptions.karOrani,
                groupValue: _character,
                onChanged: (RadioButtonOptions? value) {
                  setState(() {
                    _character = value;
                    disableUrunStokMiktari = false;
                    disableUrunBirimMaliyet = false;
                    disableKDV = false;
                    disableKarOrani = true;
                    disableUrunToplamFiyat = false;
                  });
                }),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: urunStokMiktariController,
              enabled: !disableUrunStokMiktari,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: "Ürün Stok Miktarı",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(30.0),
                      left: Radius.circular(30.0)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: urunBirimMaliyetController,
              enabled: !disableUrunBirimMaliyet,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: "Ürün Birim Maliyeti",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(30.0),
                      left: Radius.circular(30.0)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              enabled: !disableKDV,
              controller: kdvOrani,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: "KDV (%)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(30.0),
                      left: Radius.circular(30.0)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: TextField(
              enabled: !disableKarOrani,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: "Kar Oranı",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(30.0),
                      left: Radius.circular(30.0)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: urunToplamFiyatController,
              enabled: !disableUrunToplamFiyat,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: "Ürün Toplam Fiyatı",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(30.0),
                      left: Radius.circular(30.0)),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color.fromARGB(209, 168, 42, 218)),
                      ),
                    onPressed: () {},
                    child: const Text("DÜZENLE"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(const Color.fromARGB(255, 192, 6, 6)),
                      ),
                    onPressed: () {},
                    child: const Text("SİL"),
                  ),
                  const SizedBox(width: 8),
                   Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey.shade800),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("KAPAT"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      )),
    );
  }
}
