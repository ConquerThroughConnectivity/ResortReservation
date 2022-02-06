import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/screens/Admin/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResortAdminController extends GetxController{

    var controller =Get.put(AdminController());
    var onEmail ="".obs; 
    var onPassword ="".obs;
    var onFirstname ="".obs;
    var onLastname ="".obs;
    var onResort ="".obs;
    var onEntrance ="".obs;
    final db = FirebaseFirestore.instance;


  Stream<QuerySnapshot<Object>> getMessage(String userID){
  // Query colllection =FirebaseFirestore.instance.collection("Chats").where("resortID", isEqualTo: userID).orderBy("date");

  return db.collection("Chats").where("resortID", isEqualTo: userID).snapshots();
  }


  Stream<QuerySnapshot<Object>> getReservation(String resortID){
  return db.collection("Reservation").where("resortname", isEqualTo: resortID).snapshots();
  }
  Stream<QuerySnapshot<Object>> getResort(String resortname){
  return db.collection("Resorts").where("resortname", isEqualTo: resortname).snapshots();
  }


updateResortLimit({String reservationID, String limit}){
  var collection = FirebaseFirestore.instance.collection('Resorts');
  collection.doc(reservationID).update(
    {
    'resortlimit' : limit,
    }) 
    .then((_) {
      Get.snackbar("Booking Confirmed", "Success", backgroundColor: AppColors.green, barBlur: 2.5,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(20),
          colorText: Colors.white,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          snackPosition: SnackPosition.TOP);
    })
    .catchError((error){
   print(error);
    });
}

 updateFields({String reservationID}){
  var collection = FirebaseFirestore.instance.collection('Reservation');
  collection.doc(reservationID).update(
    {
    'Confirmation' : true,
    }) 
    .then((_) {
      Get.snackbar("Update Success", "Success", backgroundColor: AppColors.green, barBlur: 2.5,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(20),
          colorText: Colors.white,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          snackPosition: SnackPosition.TOP);
    })
    .catchError((error){
   print(error);
    });
}

  Stream<QuerySnapshot<Object>> getMessageList(String resortID){
  return db.collection("Chats").where("", isEqualTo: resortID).snapshots();
  }

  Future<void> sendMessage({String resortID, String message}) async {
    try {
      final collRef = FirebaseFirestore.instance.collection('Chats');
      DocumentReference users = collRef.doc();
      var date =DateTime.now();
      await users.set(({
        'messages': message,
        'resortID':resortID,
        'chatID':users.id,
        'isSender':false,
        'isResort':true,
        'date':date,
      })).then((value){
        return;
      });
    } catch (e) {
     
         
    }
  }

    updateDetails({String email, String password, String firstname, String lastname, String userID})async{
      if(email!=null || password !=null || firstname !=null || lastname !=null){
        await FirebaseFirestore.instance.collection("Users").doc(userID).update({
          "email":email,
          "password":password,
          "firstname":firstname,
          "lastname":lastname,
        }).whenComplete((){
           Get.showSnackbar(controller.SuccessSnackBar(message: "Saved Succesful"));
        });
      }else{
          Get.showSnackbar(controller.ErrorSnackBar(message: "Empty Fields"));
      }
        
    }

    clearSets(){
        onEmail ="".obs;
        onPassword ="".obs;
        onFirstname ="".obs;
        onLastname ="".obs;
        onResort ="".obs;
        onEntrance ="".obs;
        update();
    }
   
    

    emailCheck(String data){
      onEmail =data.obs;
      update();
    }
    passwordCheck(String data){
      onPassword =data.obs;
      update();
    }
    firstnameCheck(String data){
      onFirstname =data.obs;
      update();
    }
    lastnameCheck(String data){
      onLastname =data.obs;
      update();
    }
    resortCheck(String data){
      onResort =data.obs;
      update();
    }
    entranceCheck(String data){
      onEntrance =data.obs;
      update();
    }
   @override
   void onClose() {
     super.onClose();
   } 

   @override
   void dispose() {
    super.dispose();
  }
  
   @override
   void onInit() {
    super.onInit();
  }
}