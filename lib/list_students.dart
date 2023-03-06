import 'package:flutter/material.dart';

import 'db.dart';
import 'edit_student.dart';

class ListStudents extends StatefulWidget {
  const ListStudents({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListStudents();
  }
}

class _ListStudents extends State<ListStudents> {
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
      slist = await mydb.db.rawQuery('SELECT * FROM students');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Students"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.isEmpty
              ? const Text("No any students to show.")
              : Column(
                  children: slist.map(
                    (stuone) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.people),
                          title: Text(stuone["name"]),
                          subtitle: Text("Roll No:" +
                              stuone["roll_no"].toString() +
                              ", Add: " +
                              stuone["address"]),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return EditStudent(
                                          rollno: stuone["roll_no"]);
                                    }));
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () async {
                                    await mydb.db.rawDelete(
                                        "DELETE FROM students WHERE roll_no = ?",
                                        [stuone["roll_no"]]);
                                    print("Data Deleted");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Student Data Deleted")));
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
