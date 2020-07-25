import 'package:coruscate_task/address_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiData{
  Future<List<AddressClass>> getadvice() async {
    var data = await http.get("https://jsonplaceholder.typicode.com/users");

    var jsonData = json.decode(data.body);
    // print(jsonData);
    List<AddressClass> apiAddressList = [];
    for(int i=0;i<jsonData.length;i++){
      Map<String,dynamic> m = {};
      m['id'] = null;
      m['firstname'] = jsonData[i]['username'];
      m['lastname'] = jsonData[i]['name'];
      m['address'] = (jsonData[i]['address']['city']).toString();
      m['pincode'] = jsonData[i]['address']['zipcode'];
      m['mobilenumber'] = jsonData[i]['phone'];
      AddressClass add = AddressClass.fromMap(m);
      apiAddressList.add(add);
    }
    return apiAddressList;
  }
}