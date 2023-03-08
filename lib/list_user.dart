import 'package:flutter/material.dart';

import 'db.dart';
import 'edit_user.dart';

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListUser();
  }
}

class _ListUser extends State<ListUser> {
  List<Map> slist = [];
  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(const Duration(milliseconds: 500), () async {
      slist = await mydb.db.rawQuery('SELECT * FROM UserInfo');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of User"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.isEmpty
              ? const Text("No any User to show.")
              : Column(
                  children: slist.map(
                    (userone) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.people),
                          title: Text(userone["fname"]),
                          subtitle: Text(
                            "${userone["lname"]}, " + userone["mno"].toString(),
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return EditUser(mno: userone["mno"]);
                                    }));
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () async {
                                    await mydb.db.rawDelete(
                                        "DELETE FROM UserInfo WHERE mno = ?", [
                                      userone["mno"],
                                    ]);
                                    print("Data Deleted");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("User's Data Deleted")));
                                    getdata();
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red))
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
        ),
      ),
    );
  }
}
