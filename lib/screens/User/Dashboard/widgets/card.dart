/*
 * Copyright (c) 2020 .
 */
import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/User/Dashboard/ResortDetails.dart';
import 'package:ResortReservation/screens/User/Dashboard/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';


class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
    this.isFirst,
    this.isLast,
    this.photoUrl,
    this.resortname,
    this.resortaddres,
    this.resortfee,
    this.len, this.amenties, 
    this.photos, this.resortID, this.details, this.contact, this.type, this.userID, this.limitations,
  }) : super(key: key);

  final photoUrl;
  final bool isFirst;
  final bool isLast;
  final String resortname;
  final String resortaddres;
  final String resortfee;
  final int len;
  final List<dynamic> amenties;
  final List<dynamic> photos;
  final String resortID;
  final String userID;
  final String details;
  final String contact;
  final String type;
  final String limitations;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (snapshots){
    //   double total =0.0;
    //  for(int z=0;z<snapshots.addReviews.length;z++){
    //    print(snapshots.addReviews.length);
    //    total =(total + double.parse(snapshots.addReviews[z]['Rating']) /5);
    //  }
        return InkWell(
      onTap: (){
        

        Get.to(()=>ResortDetails(
          photos, 
          resortname, 
          resortaddres,
          resortfee,
          resortID,
          details,
          contact,
          type,
          amenties,
          userID,
          limitations
          ));
       
      },
      child: Container(
        child: Hero(
          tag: "Card",
          child: Container(
            width: double.infinity,
            height: 380,
            padding: EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 20),
            margin: EdgeInsets.only(
                left: 20, right: 20, top: topMargin, bottom: bottomMargin),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      photoUrl,
                    ),
                    colorFilter: ColorFilter.mode(
                        Colors.white12.withOpacity(0.7), BlendMode.luminosity)),
                color: Colors.white60,
                borderRadius: buildBorderRadius,
                boxShadow: [
                  BoxShadow(
                      color: Get.theme.focusColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5)),
                ],
                border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        resortname,
                        style: TextStyle(
                          fontFamily: "Glee",
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.pin_drop,
                      color: Colors.blue.shade300,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        resortaddres,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: "Glee",
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Fee: $resortfee",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: "Glee",
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                 Center(
                  child: Container(
                    child: Text("Resort Limit: $limitations", style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "glee",
                      fontSize: 15
                    ),),
                  ),
                ),
                 SizedBox(height: 10,),
                Center(
                  child: Container(
                    child: Text("Amenties", style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: "glee",
                      fontSize: 15
                    ),),
                  ),
                ),
               
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: amenties.length,
                      itemBuilder: (context, index) {
                        return Container(
                          
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            image:DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              amenties[index]['Photo'],
                            ),
                          colorFilter: ColorFilter.mode(
                              Colors.white12.withOpacity(0.5), BlendMode.luminosity)),
                            color: AppColors.lighgrey,borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                            BoxShadow(
                                color: Get.theme.focusColor.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(0, 5)),
                          ],
                            ),
                          child: Center(
                            child: Text(" \n Title: ${amenties[index]['Title']} \n Description: ${amenties[index]['Description']} \n Price: ${amenties[index]['Price']}",
                              style: TextStyle(
                              fontFamily: 'Glee',
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 10),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: RatingBar.builder(
                      glow: true,
                      initialRating: 3,
                      ignoreGestures: true,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                ),
               Container(
                  padding: EdgeInsets.only(left: 75, top: 10),
                  child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            showDialog(
                            context: context,
                            barrierDismissible: true, // set to false if you want to force a rating
                            builder: (context){
                              return RatingDialog(
                              initialRating: 1.0,
                              // your app's name?
                              title: Text(
                                'Rate This Resort',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              message: Text(
                                'Tap a star to set your rating. Add more description here if you want.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 15),
                              ),
                              // your app's logo?
                              image: Container(
                               
                                child: Image.asset(AppIcons.icon2, fit: BoxFit.cover,)),
                              submitButtonText: 'Submit',
                              commentHint: 'Leave a simple review on this resort thank you',
                              onCancelled: () => print('cancelled'),
                              onSubmitted: (response) {
                                print(resortID);
                                snapshots.review(
                                  userID: userID,
                                  comment: response.comment,
                                  rating: response.rating.toString(),
                                  resortID: resortID
                                );
                                print('rating: ${response.rating}, comment: ${response.comment}');
                                
                                
                              },
                            );
                            },
                          );
                          },
                          child: Container(
                            child: Text("Write Review", style: TextStyle(
                              fontFamily: 'glee',
                            
                              fontSize: 15,
                            )),
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){
                        print("object");
                      }, icon: Icon(Icons.share, color: Colors.black)),
                      SizedBox(width: 20,),
                     
                    ],
                  ),
                )
    
              ],
            ),
          ),
        ),
      ),
    );
    });
  }

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst) {
      return BorderRadius.vertical(top: Radius.circular(20));
    }
    if (isLast != null && isLast) {
      return BorderRadius.vertical(bottom: Radius.circular(20));
    }
    if (isFirst != null && !isFirst && isLast != null && !isLast) {
      return BorderRadius.all(Radius.circular(25));
    }
    return BorderRadius.all(Radius.circular(25));
  }

  double get topMargin {
    if ((isFirst != null && isFirst)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }

  static InputDecoration getInputDecoration(
      {String hintText = '',
      String errorText,
      IconData iconData,
      Widget suffixIcon,
      Widget suffix}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: Get.textTheme.caption,
      prefixIcon: iconData != null
          ? Icon(iconData, color: Get.theme.focusColor).marginOnly(right: 14)
          : SizedBox(),
      prefixIconConstraints: iconData != null
          ? BoxConstraints.expand(width: 38, height: 38)
          : BoxConstraints.expand(width: 0, height: 0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.all(0),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      suffixIcon: suffixIcon,
      suffix: suffix,
      errorText: errorText,
    );
  }
}
