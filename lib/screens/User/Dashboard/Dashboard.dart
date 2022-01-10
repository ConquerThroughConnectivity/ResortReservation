import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/colors/icons.dart';
import 'package:ResortReservation/screens/User/Dashboard/Beach.dart';
import 'package:ResortReservation/screens/User/Dashboard/Pool.dart';
import 'package:ResortReservation/screens/User/Dashboard/controller.dart';
import 'package:ResortReservation/screens/User/Dashboard/widgets/logout.dart';
import 'package:ResortReservation/screens/User/Dashboard/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:tab_container/tab_container.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';


class Dashboard extends GetView<UserController> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child:Scaffold(
        key: _key,
        drawer:Drawer(
        
        elevation: 5.0,
        child: Container(
          color: AppColors.background,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
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
              DrawerLinkWidget(
              icon: Icons.chat_outlined,
              text: "Messages",
              onTap: (e) async {
                
              },
            ),
               DrawerLinkWidget(
              icon: Icons.book_rounded,
              text: "Completed Bookings",
              onTap: (e) async {
                
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
                Get.bottomSheet(
                    LogoutConfirmation(),
                    isScrollControlled: false,
                  );
              },
            ),
            ],
          ),
        ),
      ),
        appBar: AppBar(
          leading: IconButton(onPressed: (){
          _key.currentState.openDrawer();

          }, icon: Icon(Icons.menu, color: Colors.black)),
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 50,
          title: Row(
            children: [
              SizedBox(width: 70,),
              Text("Dashboard",  style: TextStyle(
                fontFamily: 'SFS',
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),)
            ],
          ),
        ),
        backgroundColor: AppColors.background,
        body: GetBuilder<UserController>(
          init: UserController(),
          builder: (dashboard){
          return Container(
          height: MediaQuery.of(context).size.height /2 * 2.0 ,
          child: TabContainer(
            transitionBuilder: (child, animation) {
            animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
            return SlideTransition(
             position: Tween(
             begin: const Offset(0.2, 0.0),
             end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: FadeTransition(
            opacity: animation,
            child: child,
                ),
              );
          },
            color: AppColors.cardLightMaroon,
            tabEdge: TabEdge.top,    
            radius: 10,
            children: [     
              Beach(),
              Pool()
            ], 
           
           tabs: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Beach", style: TextStyle(
                  fontFamily: "glee",
                  fontSize: 15
                ),),
                SizedBox(width: 10,),
                Icon(Icons.beach_access_rounded),
              ],
            ),
           Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Pool", style: TextStyle(
                  fontFamily: "glee",
                  fontSize: 15
                ),),
                SizedBox(width: 10,),
                Icon(Icons.pool_sharp),
              ],
            ),
           
           ]),
        );
        })
      )
    );
  }
}