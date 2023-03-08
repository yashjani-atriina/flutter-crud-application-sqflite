import 'package:flutter/material.dart';

import 'db.dart';
import 'list_user.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddUser();
  }
}

class _AddUser extends State<AddUser> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mno = TextEditingController();

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
        title: const Text("Add User"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: fname,
              decoration: const InputDecoration(
                hintText: "First Name",
              ),
            ),
            TextField(
              controller: lname,
              decoration: const InputDecoration(
                hintText: "Last Name",
              ),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            TextField(
              controller: mno,
              decoration: const InputDecoration(
                hintText: "Mobile No",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                mydb.db.rawInsert(
                    "INSERT INTO UserInfo (fname, lname, email, mno) VALUES (?, ?, ?, ?);",
                    [fname.text, lname.text, email.text, mno.text]);

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("New User Added")));

                fname.text = "";
                lname.text = "";
                email.text = "";
                mno.text = "";
              },
              child: const Text("Submit"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const ListUser();
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
