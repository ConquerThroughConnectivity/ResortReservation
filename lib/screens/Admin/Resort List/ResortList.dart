import 'dart:convert';

import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/Admin/controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expansion_card/expansion_card.dart';

class ResortList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0.0,
          backgroundColor: AppColors.background,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.offAndToNamed("/home");
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Resort List",
            style: TextStyle(
              fontFamily: 'SFS',
              color: Colors.black54,
            ),
          ),
        ),
        body: GetBuilder<AdminController>(
          init: AdminController(),
          builder: (controller) {
            return WillPopScope(
              onWillPop: () async => false,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    
                    Column(
                      children: [
                         Container(
                            margin: EdgeInsets.all(20),
                         
                            height: 60,
                            child: Card(
                              elevation: 10.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextField(
                                controller:controller.searchResort,
                                decoration: InputDecoration(
                                  hintText: "Search Resort..",
                                  hintStyle: TextStyle(fontFamily: 'SFS', fontSize: 15),
                                  icon: Icon(Icons.search),
                                  border: InputBorder.none
                                ),
                                onChanged: (value){
                                  controller.changedText(value);
                                },
                              ),
                            ),


                          ),
                          SizedBox(height: 15,),
                          StreamBuilder<QuerySnapshot>(
                            stream:controller.findResort(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: Text("No Data"),
                                );
                              }
                              if (snapshot.connectionState ==ConnectionState.waiting) {
                                 return Center(
                                  child: Image.asset(
                                    AppIcons.icon,
                                    fit: BoxFit.cover,
                                    scale: 20,
                                  ),
                                );
                              } else {
                                return Container(
                                    height: MediaQuery.of(context).size.height /
                                            2 *
                                            2 -
                                        200,
                                    child: ListView.builder(
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot document =snapshot.data.docs[index];
                                          List<dynamic> photo =document['resortphoto'];
                                          List<String> addPhoto =[];
                                          photo.forEach((photos){
                                          addPhoto.add(photos);
                                          });
                                          List<dynamic> amenties =document['resortamenties'];  
                                          List<dynamic> addAmenties =[];
                                          amenties.forEach((element) {
                                              addAmenties.add(element);
                                          });
                                         
                                          return Container(
                                            margin: EdgeInsets.all(20),
                                            padding: EdgeInsets.all(20),
                                            height: 650,
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                     Container(
                                                        height: 70,
                                                        width: 70,
                                                        child: CachedNetworkImage(
                                                        imageUrl:document['resortphoto'][0],
                                                        placeholder: (context, url){
                                                        return Center(
                                                          child: Image.asset(
                                                            AppIcons.icon,
                                                            fit: BoxFit.cover,
                                                            scale: 20,
                                                          ),
                                                        ); 
                                                        },
                                                          )
                                                      ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      document['resortname'],
                                                      style: TextStyle(
                                                          fontFamily: 'SFS',
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(width: 10,),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.location_on),
                                                          Text(
                                                          document['resortaddress'],
                                                          style: TextStyle(
                                                            fontFamily: 'SFS',
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                        ),
                                                        ],
                                                      ),
                                                    ),
                                                    IconButton(onPressed: (){
                                                    controller.db.collection("Resorts").doc(document['userID']).delete().then((value){
                                                      Get.snackbar("Resort", "Resort Delete Succefull", backgroundColor: AppColors.lighgrey, snackPosition: SnackPosition.BOTTOM);
                                                    });
                                                    controller.db.collection("Users").where("resortName", isEqualTo: document['resortname']).get().then((value){
                                                      for(DocumentSnapshot ds in value.docs){
                                                       ds.reference.delete();
                                                      }                                                           
                                                    });
                                                    }, icon: Image.asset(AppIcons.removeResort)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text("Description",
                                                  style: TextStyle(
                                                      fontFamily: 'SFS',
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.cardDarkBlue,
                                                      fontSize: 20),),
                                                      SizedBox(height: 20,),
                                                Text(
                                                  document['resortdetails'],
                                                  style: TextStyle(
                                                      fontFamily: 'SFS',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                  "Amenties",
                                                  style: TextStyle(
                                                      fontFamily: 'SFS',
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.cardDarkBlue,
                                                      fontSize: 20),
                                                ),
                                                SizedBox(height: 30,),
                                             Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                                Text(
                                                  "Resort Type: ${document['resorttype']}",
                                                  style: TextStyle(
                                                      fontFamily: 'SFS',
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.cardDarkBlue,
                                                      fontSize: 10),
                                                ),
                                                Row(
                                                children: [
                                                  Text(
                                                  "Entrance Fee: ",
                                                  style: TextStyle(
                                                      fontFamily: 'SFS',
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.cardDarkBlue,
                                                      fontSize: 12),
                                                ),
                                                  
                                                 Text(
                                                  document['resortentrancefee'],
                                                  style: TextStyle(
                                                      fontFamily: 'SFS',
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.cardDarkBlue,
                                                      fontSize: 12),
                                                ),
                                                ],
                                                ),
                                             ],),
                                                Container(
                                                height: 80,
                                                  child: ListView.builder(
                                                    itemCount: addAmenties.length,
                                                    scrollDirection: Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemBuilder: (context, snapshot){
                                                    return Container(
                                                      padding: EdgeInsets.all(5),
                                                      margin: EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.lighgrey,
                                                        borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: Text(
                                                    " \n Title: ${addAmenties[snapshot]['Title']} \n Description: ${addAmenties[snapshot]['Description']} \n Price: ${addAmenties[snapshot]['Price']}",
                                                    style: TextStyle(
                                                      fontFamily: 'SFS',
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 10),
                                                    ),
                                                    );
                                                  })
                                                ),
                                                SizedBox(height: 20,),
                                                Text(
                                                  "Resort Photos ",
                                                  style: TextStyle(
                                                      fontFamily: 'SFS',
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.cardDarkBlue,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(height: 20,),
                                                Container(
                                                height: 150,
                                                  child: Carousel(
                                                  dotSize: 6.0,
                                                  dotSpacing: 15.0,
                                                  images: addPhoto.map((e) =>Container(
                                                    child: CachedNetworkImage(
                                                    imageUrl: e,
                                                    fit: BoxFit.cover
                                                    ,),
                                                  )).toList(),
                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                          );
                                        }));
                              }
                            })
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
