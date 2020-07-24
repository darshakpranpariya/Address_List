import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'address_class.dart';

class DBHelper{
  static Database _db;
  static const String ID = 'id';
  static const String FIRSTNAME = 'firstname';
  static const String LASTNAME = 'lastname';
  static const String ADDRESS = 'address';
  static const String PINCODE = 'pincode';
  static const String MOBILENUMBER = 'mobilenumber';
  static const String TABLE = 'Address';
  static const String DB_NAME = 'all_addresses.db';

  Future<Database> get db async{
    if(_db!=null)
      return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,DB_NAME);
    var db = openDatabase(path,version:1,onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db,int version) async{
    await db.execute("CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY,$FIRSTNAME TEXT,$LASTNAME TEXT,$ADDRESS TEXT,$PINCODE TEXT,$MOBILENUMBER TEXT)");
  }

  Future<AddressClass> save(AddressClass employee) async{
    var dbClient = await db;
    employee.id = await dbClient.insert(TABLE,employee.toMap());
    return employee;
  }

  Future<List<AddressClass>> getAddresses() async{
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,columns:[ID,FIRSTNAME,LASTNAME,ADDRESS,PINCODE,MOBILENUMBER]);

    //List<Employee> employees = maps.isNotEmpty ? maps.map((data)=>Employee.fromMap(data)).toList():[];
    //OR
    List<AddressClass> employees = [];
    if(maps.length>0){
      for(int i=0;i<maps.length;i++){
        employees.add(AddressClass.fromMap(maps[i]));
      }
    }
    //
    return employees;
  }

  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient.delete(TABLE,where:'$ID=?',whereArgs:[id]);
  }

  Future<int> update(AddressClass employee) async{
    var dbClient = await db;
    return await dbClient.update(TABLE,employee.toMap(),where:'$ID=?',whereArgs:[employee.id]);
  }

  Future close() async{
    var dbClient = await db;
    dbClient.close();
  }
}