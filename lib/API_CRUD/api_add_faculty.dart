import 'package:database_api_crud_trial/API_CRUD/api/api_code.dart';
import 'package:flutter/material.dart';

class API_Add_Faculty extends StatefulWidget {

  dynamic? map;
  API_Add_Faculty(this.map);

  @override
  State<API_Add_Faculty> createState() => _API_Add_FacultyState();
}

class _API_Add_FacultyState extends State<API_Add_Faculty> {

  TextEditingController facNameContoller=TextEditingController();

  @override
  void initState() {
    facNameContoller.text=widget.map==null?'':widget.map['FacultyName'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.map==null?'Add User':'Edit User')
      ),
      body: Column(
        children: [
          TextFormField(
            controller: facNameContoller,
          ),
          ElevatedButton(onPressed: () async {
            if(widget.map==null){
              Map<String, dynamic> map = {};
              map["FacultyName"] =
                  facNameContoller.text.toString();
              Map<dynamic, dynamic> facMap =
              await APICODE().insertFacultyInPost(map);
              // userId = await db.insertUserDetailInTblUser(
              //     titleController.text.toString());
              if (facMap != null) {
                Navigator.of(context).pop(true);
              }
            }
            else{
              widget.map!['FacultyName']=facNameContoller.text.toString();
              Map<dynamic,dynamic>  facMap=await APICODE().updateFacultyInPut(widget.map!);
              if(facMap!=null)
              {
                Navigator.of(context).pop(true);
              }
            }
          }, child: Text(widget.map==null?'Add User':'Edit User'),)
        ],
      ),
    );
  }
}

