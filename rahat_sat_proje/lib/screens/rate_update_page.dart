import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rahat_sat_project/model/categories_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class RateUpdate extends StatefulWidget {
  const RateUpdate({super.key});

  @override
  State<RateUpdate> createState() => _RateUpdateState();
}

enum RadioButtonOptions { KDV, KarOrani }

const List<String> _list = <String>['One', 'Two', 'Three', 'Four'];

class _RateUpdateState extends State<RateUpdate> {
  RadioButtonOptions? _character = RadioButtonOptions.KDV;
  TextEditingController selectedValue = TextEditingController();
  String? selectedCategory;

  final UserClient rateUpdate = UserClient();

  List<CategoriesModelsListing> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final categories = await rateUpdate.getAllCategories();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kategoriler yüklenirken bir hata oluştu: $e'),
        ),
      );
    }
  }

  Future<void> _submitRequest() async {
    // Kategori seçimi kontrolü
    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lütfen bir kategori seçiniz.'),
        ),
      );
      return;
    }

    // Oran türü seçimi kontrolü
    if (_character == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lütfen bir oran türü seçiniz.'),
        ),
      );
      return;
    }

    // Oran değeri kontrolü
    if (selectedValue.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lütfen bir oran değeri giriniz.'),
        ),
      );
      return;
    }

    try {
      // Oranı güncelle
      await rateUpdate.updateProductListingRates(
        selectedCategory!, // Seçilen kategori ID'si
        _character == RadioButtonOptions.KDV
            ? 'tax'
            : 'profit', // Oran türü (KDV veya Kar)
        double.parse(selectedValue.text), // Oran değeri
      );

      // Başarılı bir şekilde güncellendiğine dair geri bildirim göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ürün oranları başarıyla güncellendi.'),
        ),
      );

      // Sayfayı kapat
      Navigator.pop(context);
    } catch (e) {
      // Hata durumunda bir hata mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ürün oranları güncellenirken bir hata oluştu: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: rateUpdatePage(context),
                        padding: const EdgeInsets.only(bottom: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Column rateUpdatePage(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 10),
          child: Text(
            "Oran Güncelle",
            style: TextStyle(
              color: Colors.purple.shade100,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: CustomDropdown<String>.search(
            items: _categories.map((category) => category.name!).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = _categories
                    .firstWhere((category) => category.name == value)
                    .id; // Kategori seçildiğinde güncelle
              });
              print('changing value to: $value');
            },
            hintText: 'Kategori Seçiniz',
            excludeSelected: false,
            hideSelectedFieldWhenExpanded: true,
            decoration: CustomDropdownDecoration(
                expandedFillColor: Theme.of(context).colorScheme.surface,
                closedFillColor: Theme.of(context).colorScheme.background),
            closedHeaderPadding: const EdgeInsets.all(15),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        ListTile(
          title: const Text("KDV"),
          leading: Radio<RadioButtonOptions>(
              value: RadioButtonOptions.KDV,
              groupValue: _character,
              onChanged: (RadioButtonOptions? value) {
                setState(() {
                  _character = value;
                });
              }),
        ),
        ListTile(
          title: const Text("Kar"),
          leading: Radio<RadioButtonOptions>(
              value: RadioButtonOptions.KarOrani,
              groupValue: _character,
              onChanged: (RadioButtonOptions? value) {
                setState(() {
                  _character = value;
                });
              }),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: selectedValue,
            //enabled: !disableUrunStokMiktari,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              labelText: "Oran (%) ",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(10.0), left: Radius.circular(10.0)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
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
                  onPressed: _submitRequest,
                  child: const Text("GÜNCELLE"),
                ),
                const SizedBox(width: 20),
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
