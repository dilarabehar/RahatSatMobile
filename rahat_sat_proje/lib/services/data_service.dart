import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//stores a string in secure storage
class DataService{
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> addItem (String key, String value) async{
    try{
      if(await secureStorage.read(key: key) == null){

          await secureStorage.write(key: key, value: value);
          return true;

      }else{return false;}
      
    }catch(error){
      print(error);
      return false;

    }
  }
  //returns the requested value by key from secure storage
  Future<String?> tryGetItem(String key) async{
    try{
      return await secureStorage.read(key: key);
    }catch(error){
      print(error);
      return null;
    }
  }
}