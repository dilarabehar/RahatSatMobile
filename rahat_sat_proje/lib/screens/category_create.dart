import 'dart:convert';
import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:rahat_sat_project/services/data_service.dart';
import 'package:rahat_sat_project/services/user_client.dart';


//PLATFORM ANDROıD OLMASI GEREK

class CategoryCreatePage extends StatefulWidget {
  const CategoryCreatePage({Key? key}) : super(key: key);

  @override
  State<CategoryCreatePage> createState() => _CategoryCreatePageState();
}

class _CategoryCreatePageState extends State<CategoryCreatePage> {
  late TextEditingController categoryNameController;
  File? _image;
  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    categoryNameController = TextEditingController();
  }

  @override
  void dispose() {
    categoryNameController.dispose();
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
                  "Yeni Kategori Oluştur",
                  style: TextStyle(
                    color: Colors.purple.shade100,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: categoryNameController,
                  decoration: const InputDecoration(
                    labelText: "Kategori Adı",
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
                    createCategoryRequest();
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
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> createCategoryRequest() async {
    String categoryName = categoryNameController.text;
    File? categoryImage = _image;

    try {
      var token = await _dataService.tryGetItem("token");
      if (token == null) {
        throw Exception("Kullanıcı oturum açmamış.");
      }

      FormData formData = FormData.fromMap({
        'category_name': categoryName,
        if (categoryImage != null) 
          'category_image': await MultipartFile.fromFile(categoryImage.path),
      });

      var dio = Dio();
      var response = await dio.post(
        baseUrl + "categories/",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 201) {
        print("Kategori başarıyla oluşturuldu: ${response.data}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kategori başarıyla oluşturuldu")),
        );
      } else if (response.statusCode == 422) {
        final jsonResponse = jsonDecode(response.data);
        final message = jsonResponse['message'];
        print("Hata: $message");
        throw Exception("Kategori oluşturulurken bir hata oluştu: $message");
      } else {
        throw Exception("Kategori oluşturulurken bir hata oluştu: ${response.statusCode}");
      }
    } catch (error) {
      print("Hata: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Kategori oluşturulurken bir hata oluştu: $error")),
      );
    }
  }
}
