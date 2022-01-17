import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/User/Dashboard/controller.dart';
import 'package:ResortReservation/screens/User/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class Booking extends StatelessWidget {
 
final String userID;

  const Booking({Key key, this.userID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading:IconButton(onPressed: (){
            Get.to(User());
          }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text("My Bookings", style: TextStyle( 
            fontFamily: 'SFS',
            color: Colors.black,
            fontSize: 15,
          ),),
        ),
        body: GetBuilder<UserController>(
          init: UserController(),
          builder: (snapshots){
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Stack(
                children: [
                  Column(
                    children: [
                     StreamBuilder(
                       stream: snapshots.mybookings(userID),
                       builder: (context, data){
                         if(data.connectionState ==ConnectionState.waiting){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale: 20,),
                            ),
                          );
                        }else{
                        return  Container(
                        padding: EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height /2 * 1.8,
                        child:  ListView.builder(
                            itemCount: data.data.docs.length,
                            itemBuilder: (context, index){
                              return Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                      ),
                                      child: Card(
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      
                                ),
                              )
                          ],
                                )
                              );
                          }),
                        );
                        }
                        
                     })
                    
                    ],
                  )
                ],
            
              ),
            );
        },),
      ),
    );
  }
}