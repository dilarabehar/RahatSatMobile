import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class SellNewProduct extends StatefulWidget {
  const SellNewProduct({super.key});

  @override
  State<SellNewProduct> createState() => _SellNewProductState();
}

enum RadioButtonOptions { birimMaliyet, toplamFiyat, karOrani }

class _SellNewProductState extends State<SellNewProduct> {
  RadioButtonOptions? _character = RadioButtonOptions.birimMaliyet;

  late TextEditingController kdvOrani;
  late TextEditingController urunStokMiktariController;
  late TextEditingController urunBirimMaliyetController;
  late TextEditingController karOraniController;
  late TextEditingController urunToplamFiyatController;

  bool disableUrunStokMiktari = false;
  bool disableUrunBirimMaliyet = false;
  bool disableKDV = false;
  bool disableKarOrani = false;
  bool disableUrunToplamFiyat = true;

  final UserClient userClient = UserClient();

  @override
  void initState() {
    super.initState();
    urunStokMiktariController = TextEditingController();
    urunBirimMaliyetController = TextEditingController();
    kdvOrani = TextEditingController();
    karOraniController = TextEditingController();
    urunToplamFiyatController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: productsEditPage(context),
                padding: const EdgeInsets.only(bottom: 10),
              ),
            ),
          ]),
    );
  }

  Column productsEditPage(BuildContext context) {
    return Column(
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
                  disableUrunStokMiktari = false;
                  disableUrunBirimMaliyet = false;
                  disableKDV = false;
                  disableKarOrani = false;
                  disableUrunToplamFiyat = true;
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
                    right: Radius.circular(30.0), left: Radius.circular(30.0)),
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
                    right: Radius.circular(30.0), left: Radius.circular(30.0)),
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
                    right: Radius.circular(30.0), left: Radius.circular(30.0)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: TextField(
            enabled: !disableKarOrani,
            controller: karOraniController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              labelText: "Kar Oranı (%)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(30.0), left: Radius.circular(30.0)),
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
                    right: Radius.circular(30.0), left: Radius.circular(30.0)),
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
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(209, 168, 42, 218)),
                  ),
                  onPressed: () {},
                  child: const Text("DÜZENLE"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 192, 6, 6)),
                  ),
                  onPressed: () {},
                  child: const Text("SİL"),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey.shade800),
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
    );
  }
}