class AddressClass{
  int id;
  String firstName;
  String lastName;
  String address;
  String pinCode;
  String mobileNumber;

  AddressClass(this.id,this.firstName,this.lastName,this.address,this.pinCode,this.mobileNumber);

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      'id':id,
      'firstName':firstName,
      'lastName':lastName,
      'address':address,
      'pinCode':pinCode,
      'mobileNumber':mobileNumber
    };
    return map;
  }

  AddressClass.fromMap(Map<String,dynamic> map){
    id = map['id'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    address = map['address'];
    pinCode = map['pinCode'];
    mobileNumber = map['mobileNumber'];
  }
}