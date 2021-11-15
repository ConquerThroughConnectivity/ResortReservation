import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/Profile.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/ResortAdmin.dart';
import 'package:ResortReservation/screens/Admin/view.dart';
import 'package:ResortReservation/screens/User/service.dart';
import 'package:ResortReservation/screens/User/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{
 final data =Get.put(SharedData());
 
  FirebaseFirestore firestore;
  var isLogin =false.obs;
  @override
  void onInit() async{
   
    super.onInit();
    firestore =FirebaseFirestore.instance;
    Get.put(SharedData());
  }


Future<List> login()async{
  QuerySnapshot querySnapshot;
  List docs =[];
  try{
    querySnapshot =await firestore.collection("Users/").get();
    if(querySnapshot.docs.isNotEmpty){
      for( var doc in querySnapshot.docs.toList()){
        Map c ={
          "id": doc.id,
          "firstname": doc['firstname'],
          "lastname":doc['lastname'],
          "resortname":doc['resortname'],
          "email":doc['email'],
          "password":doc['password'],
        };
        docs.add(c);
      }
      
    }
  }catch(e){


  }
  return docs;
}
Future<void> newLogin({String email, String password})async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  isLogin =true.obs;
  update();
 try{
  CollectionReference col1 = FirebaseFirestore.instance.collection('Users');
  final list =await col1.get();
  for(int c =0;c<list.size;c++){
    if(list.docs[c]['email'] ==email && list.docs[c]['password'] ==password){
      
      
      if(list.docs[c]['tags'] =="user#"){
        // print(list.docs[c]['email']);
        // print(list.docs[c]['password']);
        // print(list.docs[c]['firstname']);


        pref.setString("userfirstname",list.docs[c]['firstname']).toString();
        pref.setString("userlastname", list.docs[c]['lastname']).toString();
        pref.setString("useremail", list.docs[c]['email']).toString();
        pref.setString("userphoto", list.docs[c]['photo']).toString();
        pref.setString("userpassword", list.docs[c]['password']).toString();
        pref.setString("userUserID", list.docs[c]['userID']).toString();
        pref.setBool("userisLogin", true);

        // print(pref.getString("userfirstname"));
        // print(pref.getString("userlastname"));
        // print(pref.getString("useremail"));
        // print(pref.getString("userphoto"));
        // print(pref.getString("userpassword"));
       print(pref.getBool("userisLogin"));
       Get.to(()=>User());
       isLogin =false.obs;
        update();
        return;
      }else if(list.docs[c]['tags'] =="admin#"){
        pref.setString("adminfirstname",list.docs[c]['firstname']).toString();
        pref.setString("adminlastname", list.docs[c]['lastname']).toString();
        pref.setString("adminemail", list.docs[c]['email']).toString();
        pref.setString("adminphoto", list.docs[c]['photo']).toString();
        pref.setString("adminpassword", list.docs[c]['password']).toString();
        pref.setString("adminUserID", list.docs[c]['userID']).toString();
        pref.setBool("adminisLogin", true);
        Get.to(()=>Home());
        isLogin =false.obs;
        update();
        return;
      }else if(list.docs[c]['tags'] =="resortadmin#"){
        pref.setString("resortadminfirstname",list.docs[c]['firstname']).toString();
        pref.setString("resortadminlastname", list.docs[c]['lastname']).toString();
        pref.setString("resortadminemail", list.docs[c]['email']).toString();
        pref.setString("resortadminpassword", list.docs[c]['password']).toString();
        pref.setString("resortadminUserID", list.docs[c]['userID']).toString();
        pref.setString("resortadminresortname", list.docs[c]['resortName']).toString();
        data.getResortAdminData();
        pref.setBool("resortadminisLogin", true);
        // print(data.resortisadminlogin.value);
        Get.to(()=>ResortAdminHome());
        isLogin =false.obs;
        update();
        return;
      }
      return;
    }else{
      isLogin =false.obs;
      update();
        // Get.snackbar("Failed", "Login Failed", backgroundColor: AppColors.cardGreyDark, barBlur: 2.5, snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
   
    
  }
  // if(istraffic ==true){
  //   Get.snackbar("Failed", "Login Failed", backgroundColor: AppColors.cardGreyDark, barBlur: 2.5, snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  //   isLogin =false.obs;
  //   update();
  // }
 }catch(e){
   Get.snackbar("Failed", "Account Doesn't Exist!", backgroundColor: AppColors.cardGreyDark, barBlur: 2.5, snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
   print(e);
 }

// FirebaseFirestore.instance.collection('Users').where('email', isEqualTo: email).get().then((QuerySnapshot querySnapsho){

// });
}
// Future<List> newLogin()async{
//   var document = await FirebaseFirestore.instance.collection('COLLECTION_NAME').doc('TESTID1');
// document.get() => then(function(document) {
//     print(document("name"));
// });

// }
}