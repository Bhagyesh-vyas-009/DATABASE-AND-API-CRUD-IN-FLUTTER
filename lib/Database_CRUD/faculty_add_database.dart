import 'package:database_api_crud_trial/Database_CRUD/db/mydatabase.dart';
import 'package:flutter/material.dart';

class Faculty_Add_Database extends StatefulWidget {
  dynamic? map;
  Faculty_Add_Database(this.map);

  @override
  State<Faculty_Add_Database> createState() => _Faculty_Add_DatabaseState();
}

class _Faculty_Add_DatabaseState extends State<Faculty_Add_Database> {
  TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    usernameController.text =
        widget.map == null ? '' : widget.map!["UserName"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.map == null ? 'Add User' : 'Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: usernameController,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (widget.map == null) {
                    MyDatabase()
                        .insertUserInTblUser(usernameController.text.toString())
                        .then((value) {
                      Navigator.of(context).pop(true);
                    });
                  } else {
                    MyDatabase()
                        .updateUserInTblUser(usernameController.text,
                            widget.map!['UserId'])
                        .then((value) {
                      Navigator.of(context).pop(true);
                    });
                  }
                },
                child: Text(widget.map == null ? 'Add User' : 'Edit User'))
          ],
        ),
      ),
    ));
  }
}
