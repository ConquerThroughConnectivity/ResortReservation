import 'dart:ui';

import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/main.dart';
import 'package:ResortReservation/screens/Login/view.dart';
import 'package:ResortReservation/screens/User/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
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
      body: SingleChildScrollView(
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
                  Padding(
                            padding: const EdgeInsets.all(20),
                            child: Card(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 3.0,
                              child: TextFormField(
                                // autofocus: true,
                              validator: (val){
                                if(val.isEmpty){
                                  return "Cannot Be Empty";
                                }
                              },
                              controller: username,
                              decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            
                              labelText: "Email",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.email, color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              
                              
                                )
                              )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Card(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 3.0,
                              child: TextFormField(
                                // autofocus: true,
                              obscureText: true,
                              validator: (val){
                                if(val.isEmpty){
                                  return "Cannot Be Empty";
                                }
                              },
                              controller: password,
                              decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            
                              labelText: "Password",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.password_rounded, color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              
                              
                                )
                              )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Card(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 3.0,
                              child: TextFormField(
                                // autofocus: true,
                           
                              validator: (val){
                                if(val.isEmpty){
                                  return "Cannot Be Empty";
                                }
                              },
                              controller: firstname,
                              decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            
                              labelText: "Firstname",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.people_alt, color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              
                              
                                )
                              )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Card(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 3.0,
                              child: TextFormField(
                                // autofocus: true,
                           
                              validator: (val){
                                if(val.isEmpty){
                                  return "Cannot Be Empty";
                                }
                              },
                              controller: lastname,
                              decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            
                              labelText: "Lastname",
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.people_alt, color: Colors.blue),
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              
                              
                                )
                              )
                            ),
                          ),
                        Align(
                        alignment: Alignment.center,
                        child:Container(
                      
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
      )

    );
  }
}