import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rahat_sat_project/model/product_model.dart';
import 'package:rahat_sat_project/services/data_provider.dart';

//when is callback function
//consumer widget is like a stateful widget and coming from riverpod
//_productData hold our data as a list
// e means each element
class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final _productData = ref.watch(productDataProvider);
    return  Scaffold(
      appBar: AppBar(
        title: Text("Ürünler"),
      ),
      body: _productData.when(data: (_productData){
        List<ProductModelCategoriesProducts> productList = _productData.map((e) => e).toList();
        return Column(
          children: [
            Expanded(child: ListView.builder(itemBuilder: (_ , index){
              return Card(
                color: Colors.deepPurple,
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  title: Text( productList[index].name ?? ' ', style: const TextStyle(
                    color: Colors.white
                  ),),
                  trailing: CircleAvatar(
                    backgroundImage: NetworkImage(productList[index].image ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1599px-Cat_poster_1.jpg' ),
                  ),
                ),
              );
            }))
            
          ],
        );
      },
       error: (err, s) => Text(err.toString()),
       loading: ()=>const Center(
        child: CircularProgressIndicator(),
       )),
    );
  }
}