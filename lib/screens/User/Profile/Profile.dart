import 'dart:ui';

import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/main.dart';
import 'package:ResortReservation/screens/Admin/widgets/text_field_widget.dart';
import 'package:ResortReservation/screens/Login/view.dart';
import 'package:ResortReservation/screens/User/Dashboard/controller.dart';
import 'package:ResortReservation/screens/User/service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

  
 final servicecontroller =Get.put(SharedData());

class UserProfile extends StatelessWidget {

  final String usernametext;
  final String passwordtext;
  final String phototext;
  final String firstnametext;
  final String lastnametext;
  final String userID;
  const UserProfile({Key key, this.usernametext, this.passwordtext, this.phototext, this.firstnametext, this.lastnametext, this.userID}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

      TextEditingController username = new TextEditingController(text:  usernametext);
      TextEditingController password = new TextEditingController(text: passwordtext);
      TextEditingController firstname = new TextEditingController(text: firstnametext);
      TextEditingController lastname = new TextEditingController(text: lastnametext);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0.0,
        backgroundColor: AppColors.background,
        title: Text("User Profile", style: TextStyle(
          fontFamily: 'SFS',
          fontSize: 20,
          color: Colors.black87
        ),),
       
      ),
      body:GetBuilder<UserController>(
        init: UserController(),
        builder:(snapshots){
          return  ModalProgressHUD(
        color: AppColors.cardYellow,
        progressIndicator: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale:20,),
        inAsyncCall: snapshots.isUpdateProfile.value, 
        child: SingleChildScrollView(
          child:Form(
            child: Stack(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    height: 230,
                    color: AppColors.cardLightMaroon,
                    
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Text("$firstnametext $lastnametext", style: TextStyle(fontFamily: 'SFS', color: Colors.black, fontSize: 20),),
                          SizedBox(height: 20,),
                          Container(
                            
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: phototext == null? Container():Image.network(
                                phototext, fit: BoxFit.cover, scale: 20, width: 150, height: 130,)),),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 250),
                   Container(
                          margin: EdgeInsets.all(5),
                          child: TextFieldWidget(
                          labelText: "Email Address".tr,
                          hintText: username.text,
                          initialValue: username.text,
                          onChanged: (input){
                            snapshots.getEmail(input);
                          },
                          onSaved: (input){
                             snapshots.getEmail(input);      
                          },
                        validator: (input) => !EmailValidator.validate(input) ? "Should be a valid email".tr : null,
                        iconData: Icons.alternate_email,
                        ),
                      ),
                          Container(
                          margin: EdgeInsets.all(5),
                          child: TextFieldWidget(
                          obscureText: true,
                          labelText: "Password".tr,
                          hintText: password.text,
                          initialValue: password.text,
                          onChanged: (input){
                            snapshots.getPassword(input);
                          },
                          onSaved: (input){
                             snapshots.getPassword(input);     
                          },
                        validator: (input) => input.length <3 ? "Characters must be greater than 3".tr : null,
                        iconData: Icons.alternate_email,
                        ),
                      ),
                          Container(
                          margin: EdgeInsets.all(5),
                          child: TextFieldWidget(
                          obscureText: true,
                          labelText: "Firstname".tr,
                          hintText: firstname.text,
                          initialValue: firstname.text,
                          onChanged: (input){
                            snapshots.getFirstname(input);
                          },
                          onSaved: (input){
                             snapshots.getFirstname(input);     
                          },
                        validator: (input) => input.length <3 ? "Characters must be greater than 3".tr : null,
                        iconData: Icons.alternate_email,
                        ),
                      ),
                          Container(
                          margin: EdgeInsets.all(5),
                          child: TextFieldWidget(
                          obscureText: true,
                          labelText: "Lastname".tr,
                          hintText: lastname.text,
                          initialValue: lastname.text,
                          onChanged: (input){
                            snapshots.getLastname(input);
                          },
                          onSaved: (input){
                             snapshots.getLastname(input);     
                          },
                        validator: (input) => input.length <3 ? "Characters must be greater than 3".tr : null,
                        iconData: Icons.alternate_email,
                        ),
                      ),
                          Align(
                          alignment: Alignment.bottomCenter,
                          child:Container(
                            margin: EdgeInsets.all(20),
                            width: double.infinity,
                            child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                               ),
                               primary: Color(0xFF306EFF),
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                textStyle: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                             ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            onPressed: (){
                              snapshots.updateFields(
                                email: snapshots.email.value =="" ?username.text :snapshots.email.value,
                                firstname: snapshots.firstname.value =="" ?firstname.text :snapshots.firstname.value,
                                lastname: snapshots.lastname.value =="" ? lastname.text :snapshots.lastname.value,
                                password: snapshots.password.value =="" ?password.text :snapshots.password.value,
                                userID: userID
                                );
                            }, 
                            child: Text("Save Details", style: TextStyle(
                              fontFamily: 'SFS',
                              fontSize: 15
                            ),)),
                          )
                        ),
                        SizedBox(height: 50,),
                            
                  ],
                )
              ],
            ),
          
        ),
        ),
      );
      })

    );
  }
}