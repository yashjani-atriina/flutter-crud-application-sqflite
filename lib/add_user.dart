import 'package:flutter/material.dart';

import 'db.dart';
import 'list_user.dart';
import 'package:intl/intl.dart';

class AddUsers extends StatefulWidget {
  AddUsers({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<StatefulWidget> createState() {
    return _AddUsers();
  }
}

class _AddUsers extends State<AddUsers> {
  TextEditingController fname = TextEditingController();
  TextEditingController mno = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateantime = TextEditingController();

  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();
    super.initState();
    dateantime.text = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Users"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: fname,
                  decoration: const InputDecoration(
                    hintText: "First Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty && value.length < 3) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: lname,
                  decoration: const InputDecoration(
                    hintText: "Last Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    hintText: "E-mail",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: mno,
                  decoration: const InputDecoration(
                    hintText: "Mobile Number",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: dateantime,
                  decoration: const InputDecoration(
                    hintText: "Date and Time",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                // Text(DateFormat('dd-mm-yyyy').format(DateTime.now())),
                ElevatedButton(
                  onPressed: () {
                    if (!widget.formKey.currentState!.validate()) {
                      return;
                    }
                    mydb.db.rawInsert(
                        "INSERT INTO UserInfo (fname, mno, lname, email, dateantime) VALUES (?, ?, ?, ?, ?);",
                        [
                          fname.text,
                          mno.text,
                          lname.text,
                          email.text,
                          dateantime.text
                        ]);

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("New Users Added")));

                    fname.text = "";
                    mno.text = "";
                    lname.text = "";
                    email.text = "";
                    dateantime.text = "";
                  },
                  child: const Text("Submit"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const ListUsers();
                        },
                      ),
                    );
                  },
                  child: const Text("Show all data"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
