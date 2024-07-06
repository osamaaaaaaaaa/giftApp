// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

Widget button(
        {required Color color,
        required String title,
        required double fontsize,
        required Color fontColor,
        required double height,
        required Function() function,
        double? border,
        Color? borderColor,
        IconData? icon,
        String? subtitle,
        required double width}) =>
    InkWell(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color,
            border: borderColor == null ? null : Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(border == null ? 10 : border)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: icon == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Container(
                      child: Icon(
                    icon,
                    size: 19,
                    color: fontColor,
                  )),
                Text(
                  title,
                  style: TextStyle(
                      color: fontColor,
                      fontSize: fontsize,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (subtitle != null)
              Text(
                subtitle.toString(),
                style: TextStyle(
                    color: fontColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
          ],
        ),
      ),
    );
