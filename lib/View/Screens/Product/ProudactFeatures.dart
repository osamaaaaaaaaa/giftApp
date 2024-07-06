// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:giftappgp/utils/AppIcons.dart';

class ProudactFeatures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
        builder: (controller) => SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    children: [
                      _widget(
                          title: 'fe1title'.tr,
                          subtitle: 'fe1stitle'.tr,
                          icon: Appicons.booster),
                      _widget(
                          title: 'fe2title'.tr,
                          subtitle: 'fe2stitle'.tr,
                          icon: Appicons.secure),
                    ],
                  ),
                  Column(
                    children: [
                      _widget(
                          title: 'fe3title'.tr,
                          subtitle: 'fe3stitle'.tr,
                          icon: Appicons.edit),
                      _widget(
                          title: 'fe4title'.tr,
                          subtitle: 'fe4stitle'.tr,
                          icon: Appicons.help24)
                    ],
                  ),
                ],
              ),
            ));
  }
}

Widget _widget({
  required String title,
  required String subtitle,
  required String icon,
}) =>
    Container(
      padding: EdgeInsets.all(15),
      width: Get.width * 0.8,
      margin: EdgeInsets.all(10),
      // decoration: BoxDecoration(color: AppColors.grey),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.2),
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)),
            child: SvgPicture.asset(icon,
                width: 35,
                height: 35,
                color: AppColors.lightPrimary,
                semanticsLabel: 'Acme Logo'),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: Get.width * 0.5),
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            ],
          ),

          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 5),
          //   child: Row(
          //     children: [
          //       // Text(
          //       //   'learnMore'.tr,
          //       //   style: TextStyle(
          //       //       color: Colors.grey,
          //       //       fontSize: 16,
          //       //       decoration: TextDecoration.underline),
          //       // ),
          //       SizedBox(
          //         width: 3,
          //       ),
          //       Container(
          //         padding: EdgeInsets.only(top: 5),
          //         child: Icon(
          //           Icons.arrow_forward,
          //           size: 15,
          //           color: Colors.grey,
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
