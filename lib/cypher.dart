import 'package:ResortReservation/screens/Admin/view.dart';
import 'package:ResortReservation/screens/Login/view.dart';
import 'package:ResortReservation/screens/User/service.dart';
import 'package:ResortReservation/screens/User/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/Admin/Resort Admin Dashboard/ResortAdmin.dart';


class Cypher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: GetBuilder<SharedData>(
          init:SharedData(),
          builder: (snapshot){
            snapshot.getResortAdminData();
            snapshot.getUserData();
            snapshot.getAdminData();
          print(snapshot.resortisadminlogin.value);
          if(snapshot.isUserlogin.value ==true){
            return User();
          }if(snapshot.isUserlogin.value ==false){
            return Login();
          }if(snapshot.isadminlogin.value ==true){
            return Home();
          }if(snapshot.resortisadminlogin.value ==true){
            return ResortAdminHome();
          }if(snapshot.resortisadminlogin.value ==false){
            return Login();
          }else{
            return Login();
          }
                                
        },)
    );
  }
}