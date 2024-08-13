import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/database.dart';
import 'package:flutter/material.dart';

import 'employee.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {


  TextEditingController NameController = new TextEditingController();
  TextEditingController AgeController = new TextEditingController();
  TextEditingController LocationController = new TextEditingController();


  Stream? EmployeeStream;


  
  getOntheLoad() async {
    EmployeeStream = await databaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getOntheLoad();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
        stream: EmployeeStream,
        builder: (context, AsyncSnapshot snapshots) {
          return snapshots.hasData
              ? ListView.builder(
                  itemCount: snapshots.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshots.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 25),
                      child: Material(
                        elevation: 5.0,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Name: " + ds["Name"],
                                    style: TextStyle(
                                        color: Colors.pinkAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: (){
                                      NameController.text=ds["Name"];
                                      AgeController.text=ds["Age"];
                                      LocationController.text=ds["Location"];
                                      EditEmployeeDetails(ds["Id"]);
                                    },
                                    child: Icon(Icons.edit,color: Colors.orangeAccent,),
                                  ),
                                  SizedBox(width: 10,),
                                  GestureDetector(
                                    onTap: () async{
                                      await databaseMethods().deleteEmployeeDetails(ds["Id"]);
                                    },
                                      child: Icon(Icons.delete,color: Colors.orangeAccent,)),
                                ],
                              ),
                              Text(
                                "Agee: " + ds["Age"],
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Location: " + ds["Location"],
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => employee()));
        },
        child: Icon(Icons.add),
      ), //
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CRUD  ",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blue,
                  fontSize: 25),
            ),
            Text(
              "APP",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.orangeAccent,
                  fontSize: 25),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }

  Future EditEmployeeDetails(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap:(){Navigator.pop(context);} ,
                          child: Icon(Icons.cancel),
                      ),
                      Text("Employee  ",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.blue,fontSize: 25),),
                      Text("Form",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.orangeAccent,fontSize: 25),),

                    ],
                  ),
                  Text("NAME" ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric( horizontal: 15,vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: NameController,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Text("Age" ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric( horizontal: 15,vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: AgeController,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Text("Location" ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric( horizontal: 15,vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(),borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: LocationController,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),

                  SizedBox(height: 25,),
                  ElevatedButton(onPressed: () async{
                    Map<String,dynamic> updateInfo = {
                      "Name": NameController.text,
                      "Age": AgeController.text,
                      "Id": id,
                      "Location": LocationController.text,
                    };
                    await databaseMethods().updateEmployeeDetails(id, updateInfo).then((value) {
                      Navigator.pop(context);
                    });
                  }, child: Text("Update"))
                ],
              ),
            ),
          ));
}
