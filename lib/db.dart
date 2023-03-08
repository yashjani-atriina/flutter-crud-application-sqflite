import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '';

class MyDb {
  late Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'UserInfo.db');
    print(path);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''

                    CREATE TABLE IF NOT EXISTS UserInfo( 
                          id primary key,
                          fname varchar(255) not null,
                          lname varchar(255) not null,
                          email varchar(255) not null,
                          mno int not null
                      );

                      //create more table here
                  
                  ''');
      print("Table Created");
    });
  }

  Future<Map<dynamic, dynamic>?> getUser(int mno) async {
    List<Map> maps =
        await db.query('UserInfo', where: 'mno = ?', whereArgs: [mno]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
}
