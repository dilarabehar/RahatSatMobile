import 'package:flutter/material.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:rahat_sat_project/screens/sell_new_product_page.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class ProductListingCreate extends StatefulWidget {
  const ProductListingCreate({super.key});

  @override
  State<ProductListingCreate> createState() => _ProductListingCreateState();
}

class _ProductListingCreateState extends State<ProductListingCreate> {
  TextEditingController barcodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  late TextEditingController productNameController;
  late TextEditingController productBarcodeController;
  late TextEditingController productMessageController;

  UserClient userClient = UserClient();
  late List<ProductListing> productListing = [];
  List<ProductListing> filteredProductListing = [];

  String? barcodeValue;
  int _pageValue = 0;
  bool _isLoading = true;

  bool isCardVisible = false;

  @override
  void initState() {
    super.initState();
    initializeProductListing();
  }

  Future<void> initializeProductListing() async {
    bool morePages = true;
    int page = 1;

    while (morePages) {
      try {
        List<ProductListing> productList =
            await userClient.fetchDataForPage(page);
        if (productList.isNotEmpty) {
          if (mounted) {
            setState(() {
              productListing.addAll(productList);
            });
          }
          page++;
        } else {
          morePages = false;
        }
      } catch (error) {
        print('Error fetching data for page $page: $error');
        morePages = false;
      }
    }

    if (mounted) {
      setState(() {
        filteredProductListing = List<ProductListing>.from(productListing);
      });
    }
  }

  void _filterProducts() {
    String nameQuery = nameController.text.toLowerCase();
    if (mounted) {
      setState(() {
        filteredProductListing = productListing.where((product) {
          return product.name.toLowerCase().contains(nameQuery);
        }).toList();
        isCardVisible = nameQuery.isNotEmpty;
      });
    }
  }

  void _filterBarcodes() {
    String barcodeQuery = barcodeController.text.toLowerCase();
    if (mounted) {
      setState(() {
        filteredProductListing = productListing.where((product) {
          return product.barcode.toLowerCase().contains(barcodeQuery);
        }).toList();
        isCardVisible = barcodeQuery.isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    barcodeController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Ürünler"),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              _searchButtons(context), // yazarak arayın - kamera ile arayın
              const SizedBox(height: 20),
              _pageValue == 0 ? _searchWithKeyboard() : _searchWithCamera(),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Center _searchButtons(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              height: 40,
              width: (MediaQuery.of(context).size.width - 100) / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: _pageValue == 1
                      ? Colors.grey // other button pressed
                      : const Color.fromARGB(192, 91, 67, 196), // active
                  foregroundColor: Colors.black, // text color
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _pageValue = 0;
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.keyboard),
                    Text("Yazarak Arayın"),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(2),
              height: 40,
              width: (MediaQuery.of(context).size.width - 100) / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: _pageValue == 0
                      ? Colors.grey
                      : const Color.fromARGB(192, 91, 67, 196),
                  elevation: 20,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isCardVisible = false;
                    _pageValue = 1;
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.photo_camera_outlined),
                    Text("Kamera İle Arayın"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _searchWithKeyboard() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: barcodeController,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 8),
              ),
              hintText: "Barkod İle Ara",
              hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
              prefixIcon: Icon(Icons.barcode_reader),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  barcodeController.clear();
                  _filterBarcodes();
                },
              ),
            ),
            onChanged: (value) {
              _filterBarcodes();
            },
          ),
          SizedBox(height: 20),
          TextField(
            controller: nameController,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 8),
              ),
              hintText: "İsim İle Ara",
              hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  nameController.clear();
                  _filterProducts();
                },
              ),
            ),
            onChanged: (value) {
              _filterProducts();
            },
          ),
          SizedBox(height: 15),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.amber,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    "Ürünleri Görmek İçin En Az 4 Karakter Uzunluğunda İsim Veya Tam Uzunlukta Barkod Girmelisiniz.",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          isCardVisible ? Flexible(child: _activeCard()) : Container(),
        ],
      ),
    );
  }

  Card _activeCard() {
    if (filteredProductListing.isEmpty) {
      return Card(
        color: Colors.white,
        elevation: 25,
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.amber,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                "Üzgünüz, aradığınız ürün bulunamadı.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.inversePrimary)),
                onPressed: () {
                  // Popup (dialog) açma işlevi
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      productNameController = TextEditingController();
                      productBarcodeController = TextEditingController();
                      productMessageController = TextEditingController();
                      return AlertDialog(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        title: Text("Yeni Ürün Talebi"),
                        contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Ürün barkodlarımız yetersiz veya yanlış ise aşağıdaki formu doldurarak bize ulaşabilirsiniz",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 15),
                            TextField(
                              controller: productNameController,
                              decoration: InputDecoration(
                                labelText: "Ürün İsmi",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                        color: Colors.black38)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              keyboardType: TextInputType.number,
                              controller: productBarcodeController,
                              decoration: InputDecoration(
                                labelText: "Ürün Barkodu",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              keyboardType: TextInputType.multiline,
                              controller: productMessageController,
                              decoration: InputDecoration(
                                labelText: "Mesajınız",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        actions: [
                          ButtonBar(
                            children: [
                              TextButton(
                                onPressed: () {
                                  try {
                                    userClient.newProductRequest(
                                        productNameController.text,
                                        productBarcodeController.text,
                                        productMessageController.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Ürün talebiniz alındı. Uygun görülürse işleme alınacak.'),
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Ürün talebi oluşturulurken bir hata oluştu: $e'),
                                      ),
                                    );
                                  }
                                  print(
                                      "Yeni ürün oluşturma talebi gönderildi");
                                  Navigator.pop(
                                      context); // Diyalog penceresini kapat
                                },
                                child: Text("Gönder"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context); // Diyalog penceresini kapat
                                },
                                child: Text("Kapat"),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Ürün Talebi Oluştur"),
              ),
            ],
          ),
        ),
      );
    } else {
      // Group products by category
      Map<String, List<ProductListing>> groupedByCategory = {};
      for (var product in filteredProductListing) {
        if (groupedByCategory.containsKey(product.category)) {
          groupedByCategory[product.category]!.add(product);
        } else {
          groupedByCategory[product.category.name] = [product];
        }
      }

      return Card(
        color: Color.fromARGB(192, 91, 67, 196),
        elevation: 25,
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: groupedByCategory.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white70,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(
                    children: entry.value.map((product) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          onTap: () {
                            print("Product selected: ${product.id}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SellNewProduct(productId: product.id),
                              ),
                            );
                          },
                          leading: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              "https://uygulama.rahatsat.com/productImages/${product.image}.jpeg",
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ürün: ${product.name}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Barkod: ${product.barcode}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      );
    }
  }

  Expanded _searchWithCamera() {
    return Expanded(child: Container());
  }
}
