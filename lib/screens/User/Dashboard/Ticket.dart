import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/User/Dashboard/controller.dart';
import 'package:ResortReservation/screens/User/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticketview/ticketview.dart';
import 'package:qr_flutter/qr_flutter.dart';
class Receipt extends StatelessWidget {
  final String userID;
  final List<dynamic> amenties;
  final String total;
  final String resortID;
  final String resortname;
  final String details;
  final String dateFrom;
  final String dateTo;
  final String persons;
  final String stayin;
  const Receipt({Key key, this.userID, this.amenties, this.total, this.resortID, this.resortname, this.details, this.dateFrom, this.dateTo, this.persons, this.stayin}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (snapshots){
      return WillPopScope(
      child: Scaffold(
      backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading:IconButton(onPressed: (){
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text("Confirm Booking", style: TextStyle( 
            fontFamily: 'SFS',
            color: Colors.black,
            fontSize: 15,
          ),),
        ),
        bottomNavigationBar: StreamBuilder<QuerySnapshot>(
          stream: snapshots.getResort1(resortID),
          builder: (context, snap){
           
         
            if(snap.connectionState ==ConnectionState.waiting){
            return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
            child: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale: 20,),
            ),
            );
          }else{          
          DocumentSnapshot document =snap.data.docs[0];
          return Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Container(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: AppColors.cardDarkBlue,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    onPressed: ()async{
                      int limitations = int.parse(document['resortlimit']) -int.parse(persons);
                      if(int.parse(document['resortlimit']) >0){
                        snapshots.book(userID, amenties, total, resortID, resortname, details, dateFrom, dateTo, stayin, persons);
                        snapshots.limitation(total: limitations.toString(), resortID:resortID);                      
                        }else{
                        Get.snackbar("This Resort is fully Book", "Error!", backgroundColor: AppColors.cardRed,
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(20),
                        dismissDirection: SnackDismissDirection.HORIZONTAL,
                        barBlur: 2.5, snackPosition: SnackPosition.TOP, colorText: Colors.white);
                      }
                    },
                    child: Text(
                      "Confirm Booking",
                      style: TextStyle(fontFamily: 'SFS', fontSize: 15),
                    )),
              )),
        );
                        
                        }
         
        }),
        body: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: TicketView(
              backgroundPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              backgroundColor: AppColors.cardDarkBlue,
              contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
              drawArc: false,
              triangleAxis: Axis.vertical,
              borderRadius: 6,
              drawDivider: true,
              trianglePos: .5,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Resortname: $resortname',
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: 'glee',
                                    fontSize: 15,
                                  ),
                                ),
                               Text(
                                  'Total: $total',
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: 'glee',
                                    fontSize: 15,
                                  ),
                                ),
                               
                              
                              ],
                            ),
                            SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                              'Amenties',
                              softWrap: true,
                              style: TextStyle(
                              fontFamily: 'glee',
                              fontSize: 15,
                              ),
                            ),
                            Text(
                              'Persons: $persons',
                              softWrap: true,
                              style: TextStyle(
                              fontFamily: 'glee',
                              fontSize: 15,
                              ),
                            )
                            ],),
                            SizedBox(height: 14),
                        Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: 
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: amenties.length,
                          itemBuilder: (__, index){
                            
                            return Container(
                            height: 70,
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: AppColors.background,borderRadius: BorderRadius.circular(10)),
                            child: Text("${amenties[index]}",
                              style: TextStyle(
                              fontFamily: 'glee',
                              fontSize: 10),
                            ),
                          );


                        })
                      
                        ),
                            SizedBox(height: 14),
                            Row(
                              children: [
                            Text(
                              'Date-From: $dateFrom',
                              style: TextStyle(
                                    fontFamily: 'glee',
                                    fontSize: 15,
                                  ),
                            ),
                            ],),
                            SizedBox(height: 14),
                            Text(
                              'Date-To: $dateTo',
                               style: TextStyle(
                                    fontFamily: 'glee',
                                    fontSize: 15,
                                  ),
                            ),
                            SizedBox(height: 14),
                            
                          ],
                        ),
                      ),
                    ),
                    QrImage(
                    data: "Resortname: $resortname, Date-From: $dateFrom, Date-To: $dateTo, Total: $total",
                    version: QrVersions.auto,
                    size: 250,
                    gapless: true,
                    
                   
                  )
                  ],
                ),
              ),
    )
            )
    ), 
    
    onWillPop: ()async=>false);
    });
  }
}