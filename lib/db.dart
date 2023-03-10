import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'userinfo.db');
    print(path);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''

                    CREATE TABLE IF NOT EXISTS UserInfo( 
                          UserId primary key,
                          fname varchar(255) not null,
                          mno int not null,
                          lname varchar(255) not null,
                          email varchar(255) not null,
                          dateantime varchar(255) not null
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
