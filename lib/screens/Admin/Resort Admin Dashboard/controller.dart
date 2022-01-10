import 'package:ResortReservation/screens/Admin/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ResortAdminController extends GetxController{

    var controller =Get.put(AdminController());
    var onEmail ="".obs; 
    var onPassword ="".obs;
    var onFirstname ="".obs;
    var onLastname ="".obs;
    var onResort ="".obs;
    var onEntrance ="".obs;


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