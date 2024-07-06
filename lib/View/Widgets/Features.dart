// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:giftappgp/utils/AppIcons.dart';

class Features extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
        builder: (controller) => SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _widget(
                      title: 'hfe1title'.tr,
                      subtitle: 'hfe1stitle'.tr,
                      icon: Appicons.right),
                  _widget(
                      title: 'hfe2title'.tr,
                      subtitle: 'hfe2stitle'.tr,
                      icon: Appicons.delevry),
                  _widget(
                      title: 'hfe3title'.tr,
                      subtitle: 'hfe3stitle'.tr,
                      icon: Appicons.delevry),
                  _widget(
                      title: 'hfe4title'.tr,
                      subtitle: 'hfe4stitle'.tr,
                      icon: Appicons.customer_service),
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
      decoration: BoxDecoration(color: AppColors.grey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: SvgPicture.asset(
              icon,
              color: AppColors.primary,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              subtitle,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
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
