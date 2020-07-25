import 'package:coruscate_task/address_class.dart';
import 'package:coruscate_task/db_helper.dart';
import 'package:coruscate_task/home_screen.dart';
import 'package:flutter/material.dart';

// Screen from which we can insert and update data...
class AddNewAddress extends StatefulWidget {
  bool isUpdating;
  String firstname;
  String lastname;
  String address;
  String pincode;
  String mobilenumber;
  int curUserId;

  AddNewAddress({Key key,this.isUpdating,this.firstname,this.lastname,this.address,this.pincode,this.mobilenumber,this.curUserId}):super(key: key);

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  Future<List<AddressClass>> addresses;
  TextEditingController controllerFirstname = TextEditingController();
  TextEditingController controllerLastname = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerPincode = TextEditingController();
  TextEditingController controllerMobileNumber = TextEditingController();


  String firstname;
  String lastname;
  String address;
  String pincode;
  String mobilenumber;
  int curUserId;
 
  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  // bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    controllerFirstname.text = widget.firstname;
    controllerLastname.text = widget.lastname;
    controllerAddress.text = widget.address;
    controllerPincode.text = widget.pincode;
    controllerMobileNumber.text = widget.mobilenumber;
    // isUpdating = false;
    // refreshList();
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (widget.isUpdating) {
        AddressClass e = AddressClass(widget.curUserId,firstname,lastname,address,pincode,mobilenumber);
        dbHelper.update(e);
        setState(() {
          widget.isUpdating = false;
        });
      } else {
        AddressClass e = AddressClass(null,firstname,lastname,address,pincode,mobilenumber);
        dbHelper.save(e);
      }
      clearName();
      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
    }
  }

  clearName() {
    controllerFirstname.text = '';
    controllerLastname.text = '';
    controllerAddress.text = '';
    controllerPincode.text = '';
    controllerMobileNumber.text = '';
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controllerFirstname,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Firstname*'),
              validator: (val) => val.length == 0 ? 'Enter FirstName' : null,
              onSaved: (val) => firstname = val,
            ),
            TextFormField(
              controller: controllerLastname,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Lastname*'),
              validator: (val) => val.length == 0 ? 'Enter LastName' : null,
              onSaved: (val) => lastname = val,
            ),
            TextFormField(
              controller: controllerAddress,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Address*'),
              validator: (val) => val.length == 0 ? 'Enter Address' : null,
              onSaved: (val) => address = val,
            ),
            TextFormField(
              controller: controllerPincode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'PIN Code*'),
              validator: (val) => val.length == 0 ? 'Enter Pincode' : null,
              onSaved: (val) => pincode = val,
            ),
            TextFormField(
              controller: controllerMobileNumber,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Mobile Number*'),
              validator: (val) => val.length < 10 ? 'Enter Correct Mobile Number' : null,
              onSaved: (val) => mobilenumber = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(widget.isUpdating ? 'UPDATE' : 'ADD'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      widget.isUpdating = false;
                    });
                    clearName();
                  },
                  child: Text('CANCEL'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Add New Address'),
        ),
        body: ListView(
          children: <Widget>[
            Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              form(),
              // list(),
            ],
          ),
          ],
        ),
      );
  }
}