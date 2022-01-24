import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/screens/User/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesList extends StatelessWidget {
  final String userID;
  final String resortID;
  const MessagesList({Key key, this.userID, this.resortID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.to(()=>User());
        }, icon: Icon(Icons.arrow_back_ios_new, color: Colors.black,)),
        title: Text("Messages List", style: TextStyle(
          fontFamily: 'SFS',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),),
      ),
          body: Stack(
            children: [
              Column(
                children: [

                ],
              )
            ],
          ),
    );
  }
}