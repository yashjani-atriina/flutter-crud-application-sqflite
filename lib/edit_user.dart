import 'package:flutter/material.dart';

import 'db.dart';
import 'list_user.dart';

class EditUser extends StatefulWidget {
  int mno;
  EditUser({super.key, required this.mno});
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  @override
  State<StatefulWidget> createState() {
    return _EditUser();
  }
}

class _EditUser extends State<EditUser> {
  TextEditingController fname = TextEditingController();
  TextEditingController mno = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateantime = TextEditingController();

  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();

    Future.delayed(const Duration(milliseconds: 500), () async {
      var data = await mydb.getUser(widget.mno);
      if (data != null) {
        fname.text = data["fname"];
        mno.text = data["mno"].toString();
        lname.text = data["lname"];
        email.text = data["email"];
        dateantime.text = data["dateantime"];
        setState(() {});
      } else {
        print("No any data with mno: " + widget.mno.toString());
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
            TextFormField(
              controller: fname,
              decoration: const InputDecoration(
                hintText: "First Name",
              ),
            ),
            TextFormField(
              controller: lname,
              decoration: const InputDecoration(
                hintText: "Last Name",
              ),
            ),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "E-mail",
              ),
            ),
            TextFormField(
              controller: mno,
              decoration: const InputDecoration(
                hintText: "Mobile Number",
              ),
            ),
            TextFormField(
              controller: dateantime,
              decoration: const InputDecoration(
                hintText: "Date and Time",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ListUsers();
                }));

                mydb.db.rawInsert(
                    "UPDATE UserInfo SET fname = ?, mno = ?, lname = ?, email = ?, dateantime = ? WHERE mno = ?",
                    [
                      fname.text,
                      mno.text,
                      lname.text,
                      email.text,
                      dateantime.text,
                      widget.mno
                    ]);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("User Data Updated"),
                  ),
                );
              },
              child: const Text("Update User Data"),
            ),
          ],
        ),
      ),
    );
  }
}
