import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/User/Dashboard/controller.dart';
import 'package:ResortReservation/screens/User/Dashboard/widgets/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Beach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.cardLightMaroon,
      body: GetBuilder<UserController>(
        init: UserController(),
        builder: (dashboard){
          return SingleChildScrollView(
              child: Stack(
              children: [
                Column(
                  children: [
                  //  Padding(
                  //         padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  //               child: Container(
                  //                 height: 60,
                  //                 child: Card(
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(10)
                  //                   ),
                  //                   color: Colors.white,
                  //                   elevation: 4.0,
                  //                   child: TextFormField(
                  //                     // onChanged: (val){
                  //                     // dashboard.resultPool(val);
                  //                     // },
                                      
                  //                     decoration: InputDecoration(
                  //                       contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  //                       labelText: "Search Beach",
                  //                       icon: Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                       ),
                  //                       border: InputBorder.none,
                  //                       focusedBorder: InputBorder.none,
                  //                       )
                  //                   ),
                  //                 ),
                  //               )
                  //             ),
                      StreamBuilder<QuerySnapshot>(
                      stream:  dashboard.searchBeach(),
                      builder: (context, snapshots){
                        if(snapshots.connectionState ==ConnectionState.waiting){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(AppIcons.icon, fit: BoxFit.cover, scale: 20,),
                            ),
                          );
                        }else{
                          return Column(
                            children: [
                            Center(
                            child: Container(
                              height: MediaQuery.of(context).size.width /2 * 3.1,
                              child: ListView.builder(
                                itemCount:snapshots.data.docs.length,
                                itemBuilder: (context, index){
                                DocumentSnapshot document =snapshots.data.docs[index];
                                // List<dynamic> displayphoto =document['resortphoto'];
                                List<dynamic> amenties =document['resortamenties'];
                                List<dynamic> amenty =[];
                                amenties.forEach((val){
                                  amenty.add(val);
                                });

                                List<dynamic> resortphoto =document['resortphoto'];
                                List<dynamic> photo =[];
                                resortphoto.forEach((val){
                                  photo.add(val);
                                });
                                
                        

                                String type = document['resorttype'].toString();

                                if(type.contains("Beach")){
                                return CardWidget(
                                photos: photo,
                                photoUrl: document['resortphoto'][0], 
                                resortname: document['resortname'], 
                                resortaddres: document['resortaddress'], 
                                resortfee: document['resortentrancefee'],
                                amenties: amenties,
                                );
                                }else{
                                return Container();
                                }
                               
                               
                               
                              }),
                            ),
                          )
                            ],
                          );
                          
                        
                        }
                    })


                  ],
                ),
              ],
            ),);
      })
    );
  }
}