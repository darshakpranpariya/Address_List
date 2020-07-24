import 'package:coruscate_task/add_new_address.dart';
import 'package:coruscate_task/address_class.dart';
import 'package:coruscate_task/db_helper.dart';
import 'package:flutter/material.dart';

// Home Screen on which all the data will be displayed from the database...
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<AddressClass>> addresses;
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshList();
  }

  refreshList() {
    setState(() {
      addresses = dbHelper.getAddresses();
    });
  }

  ListView dataTable(List<AddressClass> address){
    return ListView.builder(
      itemCount: address.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(address[index].firstName.toString()),
              subtitle: Column(
                children: <Widget>[
                  // Text("Mobile"+address[index].mobileNumber),
                  // Text(address[index].address),
                ],
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Edit'),
                  onPressed: () {
                    var route = MaterialPageRoute(
                          builder: (BuildContext context) => AddNewAddress(),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
                FlatButton(
                  child: const Text('Remove'),
                  onPressed: () {
                    dbHelper.delete(address[index].id);
                    refreshList();
                  },
                ),
              ],
            ),
          ],
        ),
      );
      }
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: addresses,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.length);
            return dataTable(snapshot.data);
          }
 
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Text("No Data Found");
          }
 
          return CircularProgressIndicator();
        },
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Address'),
        ),
        body: new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              list(),
              FlatButton(
                  child: const Text('Add new address'),
                  onPressed: () {
                    var route = MaterialPageRoute(
                          builder: (BuildContext context) => AddNewAddress(),
                    );
                    Navigator.of(context).push(route);
                  },
                ),
              
            ],
          ),
        ),
      );
  }
}