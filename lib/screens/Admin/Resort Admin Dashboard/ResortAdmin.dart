import 'package:ResortReservation/colors/colors.dart';
import 'package:ResortReservation/screens/Admin/Add%20Resort/addResort.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/Profile.dart';
import 'package:ResortReservation/screens/Admin/Resort%20Admin%20Dashboard/Reservation.dart';
import 'package:ResortReservation/screens/Admin/controller.dart';
import 'package:ResortReservation/screens/User/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
PersistentTabController _controller = PersistentTabController(initialIndex: 0);
class ResortAdminHome extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: GetBuilder<SharedData>(
        init: SharedData(),
        builder: (snapshots){
        snapshots.getResortAdminData();
        print(snapshots.resortisadminlogin.value);
        return WillPopScope(
        onWillPop: ()async=>false,
        child: PersistentTabView(
          context,
          controller: _controller,
          screens: [
            ResortAdminReservation(
                resortname:snapshots.resortadminresortname.value,
            ),
            ResortProfile(
              email: snapshots.resortadminemail.value,
              firstname: snapshots.resortadminfirstname.value,
              lastname: snapshots.resortadminlastname.value,
              password: snapshots.resortadminpassword.value,
              userID: snapshots.resortadminUserId.value,
              resortname: snapshots.resortadminresortname.value,    
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
            curve: Curves.decelerate,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.fastOutSlowIn,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style1, 
          // Choose the nav bar style with this property.
          ),
      );
      },)
    );
  }
}