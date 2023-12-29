import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rahat_sat_proje/model/product_model.dart';
import 'package:rahat_sat_proje/services/product_service.dart';

final productDataProvider = FutureProvider<List<ProductModelCategoriesProducts>>((ref) async{
  return ref.watch(productProvider).getProduct();
});

//using for syncronized request 
//futureprovider can show error message, circularprogress and so on