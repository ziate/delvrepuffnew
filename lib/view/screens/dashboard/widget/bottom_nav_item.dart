import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  final bool isSelected;
  BottomNavItem({@required this.iconData, this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        icon: Icon(iconData,
            color: isSelected ? Color(0xffE1003C) : Colors.white, size: 25),
        onPressed: onTap,
      ),
    );
  }
}
