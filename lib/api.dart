import 'package:coruscate_task/address_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiData{
  Future<List<AddressClass>> _getadvice() async {
    var data = await http.get("https://jsonplaceholder.typicode.com/users");

    var jsonData = json.decode(data.body);
    List<AddressClass> advices_list = [];
    for(int i=0;i<jsonData.length();i++){
      AddressClass advices = AddressClass.fromMap(jsonData);
      advices_list.add(advices);
    }
    return advices_list;
  }
}