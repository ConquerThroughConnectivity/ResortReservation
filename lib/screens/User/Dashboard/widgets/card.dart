/*
 * Copyright (c) 2020 .
 */
import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/screens/User/Dashboard/ResortDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';


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
    this.photos,
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
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=>ResortDetails(photos));
      },
      child: Container(
        child: Hero(
          tag: "Card",
          child: Container(
            width: double.infinity,
            height: 300,
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
                          fontFamily: "Glee",
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    child: Text("Amenties", style: TextStyle(
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
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(color: AppColors.lighgrey,borderRadius: BorderRadius.circular(10)),
                          child: Text(" \n Title: ${amenties[index]['Title']} \n Description: ${amenties[index]['Description']} \n Price: ${amenties[index]['Price']}",
                            style: TextStyle(
                            fontFamily: 'SFS',
                            fontWeight: FontWeight.bold,
                            fontSize: 10),
                          ),
                        );
                      }),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
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
    
    
    
    
              ],
            ),
          ),
        ),
      ),
    );
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
