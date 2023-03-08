import 'package:flutter/material.dart';

import 'db.dart';

class EditUser extends StatefulWidget {
  int mno;
  EditUser({super.key, required this.mno});

  @override
  State<StatefulWidget> createState() {
    return _EditUser();
  }
}

class _EditUser extends State<EditUser> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mno = TextEditingController();

  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();

    Future.delayed(const Duration(milliseconds: 500), () async {
      var data = await mydb.getUser(widget.mno);
      if (data != null) {
        fname.text = data["fname"];
        lname.text = data["lname"];
        email.text = data["email"];
        mno.text = data["mno"].toString();
        setState(() {});
      } else {
        print("No any data with roll no: " + widget.mno.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User"),
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
                hintText: "Last Name.",
              ),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Email:",
              ),
            ),
            TextField(
              controller: mno,
              decoration: const InputDecoration(
                hintText: "Mobile No:",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                mydb.db.rawInsert(
                  "UPDATE UserInfo SET fname = ?, lname = ?, email = ? WHERE mno = ?",
                  [fname.text, lname.text, email.text, widget.mno],
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("User Data Updated"),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
