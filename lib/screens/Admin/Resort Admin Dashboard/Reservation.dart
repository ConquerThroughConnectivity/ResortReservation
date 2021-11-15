import 'package:ResortReservation/colors/colors.dart';
import 'package:flutter/material.dart';

class ResortAdminReservation extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 100,
        backgroundColor: AppColors.background,
        title:  Text("Reservations", style: TextStyle(
          fontFamily: 'SFS',
          color: Colors.black54
        ),),
      ),
    );
  }
}