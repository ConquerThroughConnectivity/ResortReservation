import 'package:ResortReservation/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LogoutConfirmation extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Get.theme.focusColor.withOpacity(0.4), blurRadius: 30, offset: Offset(0, -30)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 30,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: (Get.width / 2) - 30),
            decoration: BoxDecoration(
              color: Get.theme.focusColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Get.theme.focusColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(3),
              ),
              //child: SizedBox(height: 1,),
            ),
          ),
          Text(
            "Are you sure to logout?".tr,
            style:TextStyle(
              fontFamily: 'SFS',
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ).paddingSymmetric(horizontal: 20, vertical: 10),
          
            BlockButtonWidget(
            onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.remove("userfirstname");
            pref.remove("userlastname");
            pref.remove("useremail");
            pref.remove("userphoto");
            pref.remove("userpassword");
            pref.remove("userUserID");
            pref.remove("userisLogin");
            pref.clear();
             Get.offAndToNamed("/login");
            },
            color: Colors.white,
            text: Text(
              "Confirm".tr,
              style: Get.textTheme.headline6.merge(TextStyle(color: Colors.black)),
            ),
          ).paddingSymmetric(vertical: 30, horizontal: 20),
        ],
      ),
    );
  }
}

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget({Key key, @required this.color, @required this.text, @required this.onPressed}) : super(key: key);

  final Color color;
  final Widget text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: this.onPressed != null
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(color: this.color.withOpacity(0.3), blurRadius: 40, offset: Offset(0, 15)),
                BoxShadow(color: this.color.withOpacity(0.2), blurRadius: 13, offset: Offset(0, 3))
              ],
              // borderRadius: BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: MaterialButton(
        onPressed: this.onPressed,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        color: this.color,
        disabledElevation: 0,
        disabledColor: Get.theme.focusColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: this.text,
        elevation: 0,
      ),
    );
  }
}