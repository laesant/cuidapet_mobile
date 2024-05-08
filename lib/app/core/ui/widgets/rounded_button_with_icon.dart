import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:flutter/material.dart';

class RoundedButtonWithIcon extends StatelessWidget {
  const RoundedButtonWithIcon(
      {super.key,
      required this.onTap,
      required this.width,
      required this.color,
      required this.icon,
      required this.title});
  final GestureTapCallback onTap;
  final double width;
  final Color color;
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: width,
        height: 45.h,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 25.w,
            ),
            const VerticalDivider(
              color: Colors.white,
              thickness: 2,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
