import 'dart:io';

import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/User/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';


final controller = Get.put(SignupController());

class Signup extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0.0,
        title: Text(
          "User Signup",
          style: TextStyle(fontFamily: 'SFS', color: Colors.black54),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async{
            Get.offAndToNamed("/login");
           
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
      ),
      body: GetBuilder<SignupController>(
        init: SignupController(),
        builder: (snapshot){
      return ModalProgressHUD(
        color: AppColors.cardYellow,
        progressIndicator: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale:20,),
        inAsyncCall: snapshot.isLogin.value,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(""),
                          InkWell(
                              onTap: () {
                                controller.getImage(ImageSource.gallery, context);
                              },
                              child: Center(
                                  child: Obx(() =>
                                      controller.selectedImagePath.value == ''
                                          ? Image.asset(AppIcons.addImage,
                                              fit: BoxFit.cover,
                                              height: 50,
                                              width: 50)
                                          : Container(
                                              height: 150,
                                              width: 150,
                                              
                                              child: ClipRRect(
                                                
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                child: Image.file(
                                                  File(controller
                                                      .selectedImagePath.value),
                                                  fit: BoxFit.cover,
                                                  filterQuality: FilterQuality.high,
                                                ),
                                              ),
                                            )))),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                elevation: 3.0,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Cannot Be Empty";
                                      }
                                    },
                                    controller: controller.username,
                                    decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 10),
                                        labelText: "Email",
                                        icon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.mail_outline,
                                              color: Colors.black),
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Color(0xFFF1EBDF),
                              elevation: 3.0,
                              child: TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Cannot Be Empty";
                                    }
                                    if(val.length <10){
                                      return "Password Length must be above 9 characters";
                                    }
                                  },
                                  controller: controller.password,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      labelStyle: TextStyle(fontFamily: 'SFS'),
                                      labelText: "Password",
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.password_outlined,
                                            color: Colors.black),
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none)
                                      
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.white,
                              elevation: 3.0,
                              child: TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Cannot Be Empty";
                                    }
                                  },
                                  controller: controller.firstname,
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      labelStyle: TextStyle(fontFamily: 'SFS'),
                                      labelText: "Firstname",
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.person,
                                            color: Colors.black),
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Color(0xFFF1EBDF),
                              elevation: 3.0,
                              child: TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Cannot Be Empty";
                                    }
                                  },
                                  controller: controller.lastname,
                                  decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      labelStyle: TextStyle(fontFamily: 'SFS'),
                                      labelText: "Lastname",
                                      icon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.person,
                                            color: Colors.black),
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      primary: Color(0xFF306EFF),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                      textStyle: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    onPressed: () {
                                      if (_formKey.currentState.validate() && controller.selectedImagePath.value!=null) {
                                        controller.checkDuplicate(controller.username.text, controller.password.text, controller.firstname.text, controller.lastname.text);
                                        // Get.offAndToNamed("/login");
                                      } 
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontFamily: 'SFS', fontSize: 15),
                                    )),
                              )),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
      },)
    );
  }
}
