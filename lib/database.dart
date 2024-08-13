import 'package:cloud_firestore/cloud_firestore.dart';

class databaseMethods {

  FirebaseFirestore db = FirebaseFirestore.instance;
  // CREATE
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await db
        .collection("Employee")
        .doc(id)
        .set(employeeInfoMap);
  }

  // READ
  Future<Stream<QuerySnapshot>> getEmployeeDetails() async{
    return await db.collection("Employee").snapshots();
  }


  // UPDATE
  Future updateEmployeeDetails(String id, Map<String,dynamic> updateInfo) async{
    return await db.collection("Employee").doc(id).update(updateInfo);
  }


  // DELETE
  Future deleteEmployeeDetails(String id) async{
    return await db.collection("Employee").doc(id).delete();
  }
}
