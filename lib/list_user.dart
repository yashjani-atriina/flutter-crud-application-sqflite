import 'package:flutter/material.dart';

import 'db.dart';
import 'edit_user.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListUsers();
  }
}

class _ListUsers extends State<ListUsers> {
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
        title: const Text("List of users"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.isEmpty
              ? const Text("No any users to show.")
              : Column(
                  children: slist.map(
                    (userone) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.people),
                          title: Text(userone["fname"]),
                          subtitle: Text(
                            "M.no:${userone["mno"]}\nLast Name: " +
                                userone["lname"],
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      //setState(() {});

                                      return EditUser(mno: userone["mno"]);
                                    }));
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text(
                                          'Do you want to delete this record'),
                                      // content:
                                      //     const Text('AlertDialog description'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'No'),
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            await mydb.db.rawDelete(
                                                "DELETE FROM UserInfo WHERE mno = ?",
                                                [userone["mno"]]);
                                            print("Data Deleted");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Student Data Deleted")));
                                            getdata();
                                          },
                                          // onPressed: () =>
                                          //     Navigator.pop(context, 'OK'),
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                // onPressed: () async {
                                //   await mydb.db.rawDelete(
                                //       "DELETE FROM UserInfo WHERE mno = ?",
                                //       [userone["mno"]]);
                                //   print("Data Deleted");
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(
                                //           content:
                                //               Text("Student Data Deleted")));
                                //   getdata();
                                // },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                              )
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("AlertDialog"),
      content: const Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
