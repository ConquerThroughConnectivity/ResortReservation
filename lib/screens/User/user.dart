import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/screens/User/Dashboard/Dashboard.dart';
import 'package:ResortReservation/screens/User/Profile/Profile.dart';
import 'package:ResortReservation/screens/User/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
 
PersistentTabController _controller = PersistentTabController(initialIndex: 0);
class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        bottomNavigationBar: GetBuilder<SharedData>(
          init: SharedData(),
          builder: (controller){
          controller.getUserData();
          print(controller.userphoto.value);
          print(controller.useremail.value);
          print(controller.userpassword.value);
          print(controller.userfirstname.value);
          print(controller.userlastname.value);
          return PersistentTabView(
          context,
          controller: _controller,
          screens: [
            Dashboard(),
            UserProfile(
              userID: controller.userUserId.value,
              phototext: controller.userphoto.value,
              usernametext: controller.useremail.value,
              passwordtext: controller.userpassword.value,
              firstnametext: controller.userfirstname.value,
              lastnametext: controller.userlastname.value,
            ),
            ],
          items:[
            PersistentBottomNavBarItem(
                  icon: Icon(CupertinoIcons.home),
                  title: ("Dashboard"),
                  activeColorPrimary: CupertinoColors.activeBlue,
                  inactiveColorPrimary: CupertinoColors.systemGrey,
              ),
              PersistentBottomNavBarItem(
                  icon: Icon(CupertinoIcons.profile_circled),
                  title: ("Profile"),
                  activeColorPrimary: CupertinoColors.activeBlue,
                  inactiveColorPrimary: CupertinoColors.systemGrey,
              ),],
          confineInSafeArea: true,
          backgroundColor: AppColors.cardLightMaroon, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
         
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style1, 
          // Choose the nav bar style with this property.
          );
        },)
    );
  }
}