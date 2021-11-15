import 'package:ResortReservation/colors/colors.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.background,
        elevation: 0.0,
        
        title: Text("Dashboard", style: TextStyle(
          fontFamily: 'SFS',
          fontSize: 20,
          color: Colors.black
        ),

        
        ),
      ),
    );
  }
}