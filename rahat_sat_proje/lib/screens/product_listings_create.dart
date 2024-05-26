import 'package:flutter/material.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';

class ProductListingCreate extends StatefulWidget {
  const ProductListingCreate({
    super.key,
  });

  @override
  State<ProductListingCreate> createState() => _ProductListingCreateState();
}

class _ProductListingCreateState extends State<ProductListingCreate> {
  int _pageValue = 0;
  TextEditingController barcodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  UserClient userClient = UserClient();
  late List<ProductListing> productListing;
  List<ProductListing> filteredProductListing = [];
  String? barcodeValue;

  bool isCardVisible = false;
  @override
  void initState() {
    super.initState();
    initializeProductListing();
  }

  Future<void> initializeProductListing() async {
    List<ProductListing>? productList = await userClient.getAllProduct();
    if (productList != null) {
      productListing = productList;
      filteredProductListing = List<ProductListing>.from(productListing);
    } else {}
  }

  void _filterBarcodes() {
    String barcodeQuery = barcodeController.text.toLowerCase();
    setState(() {
      filteredProductListing = productListing.where((product) {
        return product.barcode.toLowerCase().contains(barcodeQuery);
      }).toList();
      isCardVisible = barcodeQuery.isNotEmpty;
    });
  }

  void _filterProducts() {
    String nameQuery = nameController.text.toLowerCase();
    setState(() {
      filteredProductListing = productListing.where((product) {
        return product.name.toLowerCase().contains(nameQuery);
      }).toList();
      isCardVisible = nameQuery.isNotEmpty;
    });
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
                      ? Colors.grey // diğerine tıklayınca
                      : const Color.fromARGB(192, 91, 67, 196), // aktif olan
                  foregroundColor: Colors.black, // yazı rengi
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      backgroundColor: _pageValue == 0
                          ? Colors.grey
                          : const Color.fromARGB(192, 91, 67, 196),
                      elevation: 20,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
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
                  )),
            )
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
    return Card(
      color: Color.fromARGB(192, 91, 67, 196),
      elevation: 25,
      margin: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(filteredProductListing.length, (index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration:  BoxDecoration(
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
                  print("saçma ürün vol bilmem kaç? bknz.. ${filteredProductListing[index].name}");
                },
                leading: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image(
                        image:
                            AssetImage(filteredProductListing[index].image))),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ürün: ${filteredProductListing[index].name}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Barkod: ${filteredProductListing[index].barcode}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Expanded _searchWithCamera() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, index) {
          return Card(
            color: Colors.blueGrey,
            elevation: 25,
            margin: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: SizedBox(
              width: 100,
              height: 220,
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 170,
                            width: 150,
                            child: Image(
                              image: NetworkImage("sasasasa"),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.blue,
                              textStyle: const TextStyle(fontSize: 18),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text("Detay.."),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
