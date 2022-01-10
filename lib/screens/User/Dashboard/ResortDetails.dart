import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/screens/User/Dashboard/controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ResortDetails extends GetView<UserController> {
  final List<dynamic> photos;
  ResortDetails(this.photos);

  @override
  Widget build(BuildContext context) {
    print("Photos $photos");
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Hero(
          tag: "Card",
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: Carousel(
                        dotSize: 6.0,
                        dotSpacing: 15.0,
                        images: photos
                            .map((e) => Container(
                                  child: CachedNetworkImage(
                                    imageUrl: e,
                                    fit: BoxFit.cover,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
