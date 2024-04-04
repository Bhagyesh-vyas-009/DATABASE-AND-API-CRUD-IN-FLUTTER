import 'package:database_api_crud_trial/API_CRUD/api/api_code.dart';
import 'package:database_api_crud_trial/API_CRUD/api_add_faculty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class API_List extends StatefulWidget {

  @override
  State<API_List> createState() => _API_ListState();
}

class _API_ListState extends State<API_List> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("API CRUD Demo"),
      actions: [
        IconButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return API_Add_Faculty(null);
          },)).then((value) {
            if(value==true){
              setState(() {

              });
            }
          });
        }, icon: Icon(Icons.add,color: Colors.cyan,))
      ],),
      body: FutureBuilder(future: APICODE().getAllFacultiesFromAPI(), builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(snapshot.data![index]["FacultyName"])),
                      IconButton(onPressed: () async {
                        showCupertinoDialog(context: context, builder: (context) {
                          return CupertinoAlertDialog(title: Text("Alert"),
                            content: Text("Are you sure??"),
                            actions: [
                              TextButton(onPressed: () async {
                                await APICODE().deleteFacultyFromAPI(snapshot.data![index]["id"]).then((value) {
                                  Navigator.pop(context);
                                }).then((value) {
                                  setState(() {

                                  });
                                });
                              }, child: Text("Yes")),
                              TextButton(onPressed: () {
                                Navigator.pop(context);
                              }, child: Text("No"))
                            ],);
                        },);
                      }, icon: Icon(Icons.delete,color: Colors.red,)),
                      IconButton(onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return API_Add_Faculty(snapshot.data![index]);
                        },)).then((value){
                          if(value==true)
                            {
                              setState(() {
                                
                              });
                            }
                        });
                      }, icon: Icon(Icons.edit))
                    ],
                  ),
                ),
              ),
            );
          },itemCount: snapshot.data!.length,);
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
      },),
    );
  }
}
