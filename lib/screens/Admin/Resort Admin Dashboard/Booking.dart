import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Reservations extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResortAdminController>(
      init: ResortAdminController(),
      builder: (snapshots){
        return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios_new, color: Colors.black,)),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Accepted Bookings", style: TextStyle(
            fontFamily: 'SFS',
            fontSize: 15,
            color: Colors.black

          ),),
          
      ),
    );
    });
  }
}