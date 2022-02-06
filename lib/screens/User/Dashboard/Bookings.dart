import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Login/view.dart';
import 'package:ResortReservation/screens/Login/view.dart';
import 'package:ResortReservation/screens/User/Dashboard/controller.dart';
import 'package:ResortReservation/screens/User/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class Booking extends StatelessWidget {
 
final String userID;
final String resortID;
final String resortname;
final String details;

  const Booking({Key key, this.userID, this.resortID, this.resortname, this.details}) : super(key: key);
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
                        child: ListView.builder(
                            itemCount: data.data.docs.length,
                            itemBuilder: (context, index){
                              DocumentSnapshot doc  =data.data.docs[index];
                              List<dynamic> amenties =doc['amenties'];
                                List<dynamic> amenty =[];
                                amenties.forEach((val){
                                  amenty.add(val);
                                });
                             
                              return Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 270,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                      ),
                                      child: Card(
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Order Confirmed:", 
                                                style: TextStyle(
                                                fontFamily: 'glee',
                                                fontSize: 12,
                                                ),),
                                                SizedBox(width: 10,),
                                                Text("${doc['Confirmation'].toString()}", style:TextStyle(
                                                fontFamily: 'glee',
                                                color: doc['Confirmation'].toString().contains("false") ?Colors.red :Colors.green,
                                                fontSize: 12,
                                                ) ),
                                                  ],
                                                ),
                                                Text("Total:  ${doc['total']}", style: TextStyle(
                                                fontFamily: 'glee',
                                                color:Colors.black,
                                                fontSize: 12,
                                                ),),
                                              ],
                                            ),
                                            SizedBox(height: 35),
                                            Container(
                                              margin: EdgeInsets.all(15),
                                              height: 50,
                                              child: Text("Resortname: ${doc['resortname']} ResortDetails: ${doc['resortdetails']}", style: TextStyle(
                                                  fontFamily: 'SFS',
                                                  fontSize: 13,
                                              ),),
                                            ),
                                            Container(
                                            height: 100,
                                            padding: EdgeInsets.only(bottom: 10),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: amenty.length,
                                              itemBuilder: (context, indices){
                                              return  Container(
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(color: AppColors.lighgrey,borderRadius: BorderRadius.circular(10)),
                                              child: Text("${amenty[indices]}",
                                                style: TextStyle(
                                                fontFamily: 'SFS',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                              ),
                                            );
                                            })
                                          ),

                                          ],
                                        ),
                                      ) ,
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