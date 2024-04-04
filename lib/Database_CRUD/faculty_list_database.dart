import 'package:database_api_crud_trial/Database_CRUD/db/mydatabase.dart';
import 'package:database_api_crud_trial/Database_CRUD/faculty_add_database.dart';
import 'package:flutter/material.dart';

class Faculty_List_Database extends StatefulWidget {

  @override
  State<Faculty_List_Database> createState() => _Faculty_List_DatabaseState();
}

class _Faculty_List_DatabaseState extends State<Faculty_List_Database> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database CRUD Demo"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Faculty_Add_Database(null);
            },)).then((value){
              if(value==true){
                setState(() {

                });
              }
            });
          }, icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(future: MyDatabase().initDatabase(), builder: (context, snapshotCopy) {
        if(snapshotCopy.hasData){
          return FutureBuilder(future: MyDatabase().getUserListFromTblUser(), builder: (context, snapshotList) {
            if(snapshotList.hasData && snapshotList.data!=null){
              return ListView.builder(
                itemCount: snapshotList.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(snapshotList.data![index]["UserName"])),
                          IconButton(onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return Faculty_Add_Database(snapshotList.data![index]);
                            },)).then((value) {
                              if(value==true){
                                setState(() {

                                });
                              }
                            });
                          }, icon: Icon(Icons.edit)),
                          IconButton(onPressed: () {
                            MyDatabase().deleteIUserFromTblUser(snapshotList.data![index]['UserId']).then((value){
                              setState(() {

                              });
                            });
                          }, icon: Icon(Icons.delete,color: Colors.red,))
                        ],
                      ),
                    ),
                  );
                },);
            }
            else{
              return Center(child: Text("No Faculty Found"),);
            }
          },);
        }
        else{
          return Center(child:CircularProgressIndicator());
        }
      },));
  }
}
