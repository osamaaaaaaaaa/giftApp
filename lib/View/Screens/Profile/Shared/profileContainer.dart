// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:giftappgp/utils/AppColors.dart';

Widget ProfileContainer(
        {required String assetName, required String title, Function()? fun}) =>
    InkWell(
      onTap: fun,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetName,
              semanticsLabel: 'Acme Logo',
              // width: 20,
              height: 30,
              color: AppColors.primary,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.35),
              margin: EdgeInsets.all(5),
              child: Text(
                '${title}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
