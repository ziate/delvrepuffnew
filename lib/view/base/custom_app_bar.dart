import 'package:efood_multivendor_driver/theme/styles.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  final Function onBackPressed;
  CustomAppBar(
      {@required this.title,
      this.isBackButtonExist = true,
      this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: robotoRegular.copyWith(
          fontSize: Dimensions.FONT_SIZE_LARGE,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: isBackButtonExist
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              color: Theme.of(context).textTheme.bodyText1.color,
              onPressed: () => onBackPressed != null
                  ? onBackPressed()
                  : Navigator.pop(context),
            )
          : SizedBox(),
      backgroundColor: kPrimaryColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size(1170, GetPlatform.isDesktop ? 70 : 50);
}
