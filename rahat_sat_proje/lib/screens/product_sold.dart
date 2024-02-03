import 'package:flutter/material.dart';
import 'package:rahat_sat_project/model/product_model.dart';

//satılan

class ProductView extends StatefulWidget {
  final List<SoldListing> inProducts;
  
  const ProductView({Key? key, required this.inProducts}):super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState(inProducts);
}

class _ProductViewState extends State<ProductView> {

_ProductViewState(inProducts);
late List<SoldListing> products = widget.inProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Satılan Ürünler"),
        ),
        body: SingleChildScrollView(child:
        Column(children: products.map((product){
          return Padding(padding: EdgeInsets.all(3),
          child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Container(
                      width: 40.0,
                      height: 40.0,
                      color: Colors.deepPurple,
                      child: CircleAvatar(backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.deepPurple,
                      backgroundImage: NetworkImage(product.product?.image as String ?? 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1599px-Cat_poster_1.jpg' ),
                      ) ,
                    ),
                    const SizedBox(width: 5.0),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(product.product?.name ?? '',style: const TextStyle(color: Colors.black,fontSize:18.0,fontWeight: FontWeight.bold ),),
                          Text(product.product?.categoryId ?? '',style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                      ],
                    ),
                    Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Düzenle"),
                  ),
                  const SizedBox(width: 5.0),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Sil"),
                  ),],),
                  ],
                ),
                
              ),
            ),);
        }).toList()),),
      ),
    );
  }
}

//                                  7QSNTzh86EePCu3K
//          admin@rahatsat.com