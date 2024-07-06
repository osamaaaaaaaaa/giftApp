// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:giftappgp/utils/AppColors.dart';

Widget ListItem(
        {required String title,
        required String? svgicon,
        Color? color,
        Widget? widget,
        required IconData iconData,
        required Function() ontap}) =>
    InkWell(
      onTap: ontap,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)]),
        child: Row(
          children: [
            svgicon != null
                ? SvgPicture.asset(
                    svgicon.toString(),
                    height: 30,
                    width: 30,
                  )
                : Icon(
                    iconData,
                    color: color != null ? Colors.white : Colors.grey,
                  ),
            SizedBox(
              width: 10,
            ),
            widget != null
                ? widget
                : Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
          ],
        ),
      ),
    );
