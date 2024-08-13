import 'package:crud/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class employee extends StatefulWidget {
  const employee({super.key});

  @override
  State<employee> createState() => _employeeState();
}

class _employeeState extends State<employee> {


  TextEditingController NameController = new TextEditingController();
  TextEditingController AgeController = new TextEditingController();
  TextEditingController LocationController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Employee  ",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.blue,fontSize: 25),),
            Text("Form",style: TextStyle(fontWeight: FontWeight.w800,color: Colors.orangeAccent,fontSize: 25),),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 35,left: 35,right: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(height: 45),
            ElevatedButton(onPressed: () async{
              String Id = randomAlphaNumeric(10);
              Map<String, dynamic> employeeInfoMap = {
                "Name": NameController.text,
                "Age": AgeController.text,
                "Id":Id,
                "Location": LocationController.text,
              };
              await databaseMethods().addEmployeeDetails(employeeInfoMap,Id).then((value) {
                Fluttertoast.showToast(
                    msg: "Employee details has been uploaded Successfully!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              });
            }, child: Text("Add",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.blue),))
          ],
        ),
      ),
    );
  }
}
