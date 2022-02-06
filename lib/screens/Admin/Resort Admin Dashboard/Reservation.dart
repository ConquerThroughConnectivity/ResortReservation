import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/Booking.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/Confirmed.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/MessageList.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/controller.dart';
import 'package:ResortReservation/screens/User/Dashboard/widgets/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:intl/intl.dart';
class ResortAdminReservation extends StatelessWidget {
 
final String resortname;
  
  const ResortAdminReservation({Key key, this.resortname}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    return GetBuilder<ResortAdminController>(
      init: ResortAdminController(),
      builder: (snapshot){
      final format = DateFormat("yyyy-MM-dd");
        return Scaffold(
      key: _key,
      drawer: Drawer(
        elevation: 5.0,
        child: Container(
          color: AppColors.background,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Center(child: Image.asset(AppIcons.icon2, fit: BoxFit.cover, scale: 30.0,)),
                ),
              ),
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.background,
                ),
                child: Container(
                  child: WaveWidget(
                  config: CustomConfig(
                    durations: [15000, 15000, 15000], 
                    heightPercentages: [0.13, 0.25, 0.60],
                    blur: MaskFilter.blur(BlurStyle.inner, 16),
                    colors: [AppColors.cardDarkBlue, AppColors.appbar, AppColors.cardDarkBlue]
                  ), 
                  waveAmplitude: 10,
                  backgroundColor:AppColors.background,
                  size: Size(double.infinity, double.infinity),
                  ),
                )
              ),

            //   DrawerLinkWidget(
            //   icon: Icons.chat_outlined,
            //   text: "Messages",
            //   onTap: (e) async {
            //      Get.to(()=>ResortMessagesList());
            //   },
            // ),

               DrawerLinkWidget(
              icon: Icons.book_rounded,
              text: "Bookings",
              onTap: (e) async {
                Get.to(()=>Reservations());
              },
            ),
             DrawerLinkWidget(
              icon: Icons.notifications,
              text: "Notifications",
              onTap: (e) async {
                
              },
            ),
              
              DrawerLinkWidget(
              icon: Icons.logout,
              text: "Logout",
              onTap: (e) async {
                // Get.bottomSheet(
                //     Confirmation(),
                //     isScrollControlled: false,
                //   );
              },
            ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          _key.currentState.openDrawer();


          }, icon: Icon(Icons.menu, color: Colors.black)),
        elevation: 0.0,
        toolbarHeight: 100,
        backgroundColor: AppColors.background,
        title:  Text("Reservations", style: TextStyle(
          fontFamily: 'SFS',
          color: Colors.black54
        ),),
        
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: snapshot.getReservation(resortname),
                      builder:(context, snapshots){
                        if(!snapshots.hasData){
                            return Center(child: Text("No Data"));
                        }if(snapshots.connectionState ==ConnectionState.waiting){
                          return Center(
                            child: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale: 20,),
                          );
                        }else{
                           return Container(
                            height: 650,
                            child: ListView.builder(
                              itemCount: snapshots.data.docs.length,
                              itemBuilder: (ctx, index){
                              DocumentSnapshot document =snapshots.data.docs[index];
                               List<dynamic> amenties =document['amenties'];
                                List<dynamic> amenty =[];
                                amenties.forEach((val){
                                  amenty.add(val);
                                });
                             if(document['Confirmation']==false){
                              //  final date1 =DateTime.parse(document['date-from']);
                              //  final date2 =DateTime.parse(document['date-to']);
                              //  int finalDate=date2.difference(date1).inDays;
                              String dateNow =format.format(DateTime.now());
                              print(dateNow);
                                return Container(
                                margin: EdgeInsets.all(20),
                                height: 380,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 20, left: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Amenties", style: TextStyle(
                                              fontFamily: 'SFS',
                                              fontSize: 15,
                                            ),),
                                           
                                            Container(
                                              margin: EdgeInsets.only(top: 5, right: 20),
                                              child: Text("Total: ${document['total']}" ,style: TextStyle(
                                              fontFamily: 'SFS',
                                              fontSize: 15,
                                            ),)),

                                          ],
                                        ),
                                      ),
                                      Container(
                                      margin: EdgeInsets.all(8),
                                      height: 90,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.transparent
                                      ),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: amenty.length,
                                        itemBuilder: (__, index){
                                          return Container(
                                          height: 70,
                                          padding: EdgeInsets.all(5),
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(color:  AppColors.background,borderRadius: BorderRadius.circular(10)),
                                          child: Text("${amenty[index]}",
                                            style: TextStyle(
                                            fontFamily: 'SFS',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                          ),
                                        );
                                      })
                                    ),
                                     Container(
                                       padding: EdgeInsets.all(10),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Container(
                                                margin: EdgeInsets.only(top: 5, left: 10),
                                                child: Text("Resort Name: ${document['resortname']}" ,style: TextStyle(
                                                fontFamily: 'Glee',
                                                fontSize: 15,
                                              ),)),
                                               Container(
                                                margin: EdgeInsets.only(top: 5, left: 10),
                                                child: Text("Persons : ${document['persons']}" ,style: TextStyle(
                                                fontFamily: 'Glee',
                                                fontSize: 15,
                                              ),)),
                                         ],
                                       ),
                                     ),
                                     SizedBox(height: 20),
                                     Container(
                                       padding: EdgeInsets.all(10),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Container(
                                                margin: EdgeInsets.only(top: 5, left: 10),
                                                child: Text("Date From: ${document['date-from']}" ,style: TextStyle(
                                                fontFamily: 'Glee',
                                                fontSize: 15,
                                              ),)),
                                               Container(
                                                margin: EdgeInsets.only(top: 5, left: 10),
                                                child: Text("Date To : ${document['date-to']}" ,style: TextStyle(
                                                fontFamily: 'Glee',
                                                fontSize: 15,
                                              ),)),
                                         ],
                                       ),
                                     ),
                                      StreamBuilder(
                                        stream: snapshot.getResort(resortname),
                                        builder: (ctx, snaps){
                                        if(!snaps.hasData){
                                        return Center(
                                        child: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale: 20,),
                                        );
                                      }else{
                                         DocumentSnapshot doc =snaps.data.docs[0];
                                         return Container(
                                                    margin: EdgeInsets.all(20),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                        child: dateNow.contains(document['date-to']) ?
                                                        ElevatedButton(
                                                        
                                                        style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          primary: AppColors.cardDarkBlue,
                                                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                                            textStyle: TextStyle(
                                                            fontSize: 25,
                                                            fontWeight: FontWeight.bold),
                                                        ),
                                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                                        onPressed: ()async{
                                                          int total=(int.parse(doc['resortlimit']) + int.parse(document['persons']));
                                                            Get.bottomSheet(
                                                                  Confirmation(reservationID: document['reservationID'], userID: doc['userID'], total: total.toString(),),
                                                                  isScrollControlled: false,
                                                          );
                                                                
                                                        //  if(_formKey.currentState.validate() &&username.text.contains("resort#")){
                                                        //    Get.offAndToNamed("/dashboardadmin");
                                                        //  }
                                                        //  }else if(_formKey.currentState.validate() &&username.text.contains("admin#")){
                                                        //    Get.offAndToNamed("/home");
                                                        //  }else if(_formKey.currentState.validate() &&username.text.contains("user#")){
                                                        //    Get.offAndToNamed("/user");
                                                        //  }
                                                        }, 
                                                        child: Text("Confirm", style: TextStyle(
                                                          fontFamily: 'SFS',
                                                          fontSize: 15
                                                        ),)):Text("This Date cannot be confirmed", style: TextStyle(
                                                            fontFamily: 'Glee',
                                                            fontSize: 15,
                                                            
                                                          ),),
                                                        ),
                                                        
                                                      ],
                                                    ),
                                                  );
                                    }
                                       
                                      })   
                                  
                                    ],
                                  ),
                                ),
                              );
                             }else{
                               return Container();
                             }
                            }),
                          );
                        }
                         
                      } 
                      
                      ,),
                  ),
              ],
            )
          ],
        ),
      ),
    );
    }); 
  }
}