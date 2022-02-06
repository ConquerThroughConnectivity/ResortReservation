
import 'dart:io';

import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/screens/User/StorageService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


class SignupController extends GetxController {
TextEditingController username = new TextEditingController();
TextEditingController password = new TextEditingController();
TextEditingController firstname = new TextEditingController();
TextEditingController lastname = new TextEditingController();

  FirebaseFirestore firestore;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  var isLogin =false.obs;

  @override
  void onInit() {

    super.onInit();
    firestore = FirebaseFirestore.instance;
    
  }

  @override
  void dispose() {
    
    super.dispose();
    username.clear();
    password.clear();
    firstname.clear();
    lastname.clear();
    selectedImagePath=''.obs;
  }
  

  Future<void> signup(String email1, String password1, String firstname1, String lastname1) async {
    isLogin =true.obs;
    update();
      
    try {
      UploadTask task;
      task =FirebaseFileStore.uploadFile('files/$selectedImagePath', File(selectedImagePath.value));

      final collRef = FirebaseFirestore.instance.collection('Users');
      DocumentReference users = collRef.doc();
      
      if(task ==null){
        return;
      }



      final snapshot =await task.whenComplete(() {
        isLogin =false.obs;
        update();
      });



      final urlDownload =await snapshot.ref.getDownloadURL();
      await users.set(({
        'email': email1,
        'password':password1,
        'firstname':firstname1,
        'lastname':lastname1,
        'tags':"user#",
        'photo':urlDownload,
        'userID':users.id,
        })).then((value){
          Get.snackbar("Success", "Email Register Sucess", backgroundColor: AppColors.cardLightMaroon, barBlur: 2.5, snackPosition: SnackPosition.BOTTOM);
          isLogin =false.obs;
          update();
          username.clear();
          password.clear();
          firstname.clear();
          lastname.clear();
          selectedImagePath=''.obs;
          Get.offAndToNamed("/login");
        return;
      });
      
      
    } catch (e) {
      Get.snackbar("Warning", "Error!", backgroundColor: AppColors.cardGreyDark, barBlur: 2.5, snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      isLogin =false.obs;
          update();
    }
  }
  Future<void> checkDuplicate(String email, String password, String firstname, String lastname)async{
    try{
      await firestore.collection("Users").where("email", isEqualTo: email).get().then((value){
        if(value.size >0){
          Get.snackbar("Warning", "Email Already Used please use another", backgroundColor: AppColors.cardGreyDark, barBlur: 2.5, colorText: Colors.white);
        }else{
          signup(email, password, firstname, lastname);
        }
      });
    }catch(e){

    }
  }
  void getImage(ImageSource imageSource, BuildContext context) async {
    final picked = await ImagePicker().pickImage(source: imageSource);
    if (picked != null) {
      selectedImagePath.value = picked.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
    } else {
      Get.snackbar('Error', 'No Image selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
    }
  }


}
