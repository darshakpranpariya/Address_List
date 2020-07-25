import 'package:coruscate_task/add_new_address.dart';
import 'package:coruscate_task/address_class.dart';
import 'package:coruscate_task/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Home Screen on which all the data will be displayed from the database...
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<AddressClass>> addresses;
  var dbHelper;
  bool isUpdating;
  int curUserId;
  int defaultAddress;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    refreshList();
    getshar();
  }

  refreshList() {
    setState(() {
      addresses = dbHelper.getAddresses();
      // getshar();
    });
  }

  getshar() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    defaultAddress = prefs.getInt('defaultAddress');
  }

  setSharedPref(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("defaultAddress");
    prefs.setInt('defaultAddress', val);
  }

  ListView dataTable(List<AddressClass> address) {
    return ListView.builder(
        itemCount: address.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                
                // ListView(
                //   children: [
                //     Ink(
                //       color:
                //           defaultAddress == null ? Colors.white : Colors.green,
                //       child: 
                ListTile(
                        onLongPress: () {
                          setState(() {
                            setSharedPref(address[index].id);
                            getshar();
                          });
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Name : " + address[index].firstName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Mobile :" + address[index].mobileNumber),
                                Text("Address : " + address[index].address),
                                defaultAddress==address[index].id ? Text("Default") : Text('')
                              ],
                            ),
                          ],
                        ),
                      ),
                //     ),
                //   ],
                // ),
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Edit'),
                      onPressed: () {
                        var route = MaterialPageRoute(
                          builder: (BuildContext context) => AddNewAddress(
                            isUpdating: true,
                            firstname: address[index].firstName,
                            lastname: address[index].lastName,
                            address: address[index].address,
                            pincode: address[index].pinCode,
                            mobilenumber: address[index].mobileNumber,
                            curUserId: address[index].id,
                          ),
                        );
                        Navigator.pushReplacement(context, route);
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
        });
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              refreshList();
            },
          )
        ],
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
                  builder: (BuildContext context) => AddNewAddress(
                    isUpdating: false,
                    firstname: '',
                    lastname: '',
                    address: '',
                    pincode: '',
                    mobilenumber: '',
                    curUserId: null,
                  ),
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
