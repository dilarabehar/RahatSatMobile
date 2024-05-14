import 'package:barcode_scanner/scanbot_barcode_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:rahat_sat_project/services/user_client.dart';
import 'package:barcode_scanner/scanbot_sdk_models.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  UserClient userClient = UserClient();

  Future<void> fetchDataForBarcode(String barcode) async {
    try {
      int page = 1; // Start from the first page

      while (true) {
        List<ProductListing> products = await userClient.fetchDataForPage(page);

        for (var product in products) {
          if (product.barcode == barcode) {
            // Product found, show the product details
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Product Found"),
                  content: Text("Name: ${product.name}\nBarcode: ${product.barcode}"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close"),
                    ),
                  ],
                );
              },
            );
            return;
          }
        }

        // Move to the next page
        page++;

        // If there are no more pages, exit the loop
        if (products.isEmpty) {
          break;
        }
      }

      // If the barcode is not found, notify the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Product Not Found"),
            content: Text("No product found with the barcode $barcode"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Show an error dialog if an error occurs
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("An error occurred while fetching the product."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          );
        },
      );
      print(error);
    }
  }

  Future<void> scanBarcode() async {
    var config = BarcodeScannerConfiguration(
    barcodeFormats: [BarcodeFormat.CODE_128, BarcodeFormat.DATA_MATRIX],
    topBarBackgroundColor: Colors.blueAccent,
    finderTextHint: "Please align a barcode in the frame to scan it.",
    cancelButtonTitle: "Cancel",
    flashEnabled: true,
  );
  var result = await ScanbotBarcodeSdk.startBarcodeScanner(config);
  // result.barcodeItems[n].barcodeFormat
  // result.barcodeItems[n].text
  // result.barcodeItems[n].formattedResult
  }

  @override
  void initState(){

    var config = ScanbotSdkConfig(
      licenseKey: "",
      loggingEnabled: true,
    );

    ScanbotBarcodeSdk.initScanbotSdk(config);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: scanBarcode,
          child: Text('Scan Barcode'),
        ),
      ),
    );
  }
}
