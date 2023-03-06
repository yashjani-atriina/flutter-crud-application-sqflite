import 'package:flutter/material.dart';

import 'db.dart';
import 'list_students.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddStudent();
  }
}

class _AddStudent extends State<AddStudent> {
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController address = TextEditingController();

  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                hintText: "First Name",
              ),
            ),
            TextField(
              controller: rollno,
              decoration: const InputDecoration(
                hintText: "Last Name",
              ),
            ),
            TextField(
              controller: address,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            TextField(
              controller: address,
              decoration: const InputDecoration(
                hintText: "Mobile No",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                mydb.db.rawInsert(
                    "INSERT INTO students (name, roll_no, address) VALUES (?, ?, ?);",
                    [name.text, rollno.text, address.text]);

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("New Student Added")));

                name.text = "";
                rollno.text = "";
                address.text = "";
              },
              child: const Text("Submit"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const ListStudents();
                    },
                  ),
                );
              },
              child: const Text("Show all data"),
            ),
          ],
        ),
      ),
    );
  }
}
