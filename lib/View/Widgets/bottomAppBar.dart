// ignore_for_file: prefer_const_constructors, unused_import, use_key_in_widget_constructors, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/utils/AppColors.dart';

class BottomApp_Bar extends StatelessWidget {
  bool? back;
  BottomApp_Bar({required this.back});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
        init: Homecontroller(),
        builder: (controller) => Container(
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
                  color: Colors.white),
              height: 60,
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (back!) {
                        Get.back();
                      }
                      controller.handleBottomNavigatorBar(i: 0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset('assets/svg/icons8-home.svg',
                            height: 22,
                            color: controller.MainContainerBodyIndex == 0
                                ? AppColors.primary
                                : Colors.grey,
                            semanticsLabel: 'Acme Logo'),
                        Text(
                          'home'.tr,
                          style: TextStyle(
                              color: controller.MainContainerBodyIndex == 0
                                  ? AppColors.primary
                                  : Colors.grey,
                              fontSize: 14,
                              fontWeight: controller.MainContainerBodyIndex == 0
                                  ? FontWeight.bold
                                  : FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (back!) {
                        Get.back();
                      }
                      controller.handleBottomNavigatorBar(i: 2);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset('assets/svg/circle-user_9821720.svg',
                            height: 22,
                            color: controller.MainContainerBodyIndex == 2
                                ? AppColors.primary
                                : Colors.grey,
                            semanticsLabel: 'Acme Logo'),
                        Text(
                          'profile'.tr,
                          style: TextStyle(
                              color: controller.MainContainerBodyIndex == 2
                                  ? AppColors.primary
                                  : Colors.grey,
                              fontSize: 14,
                              fontWeight: controller.MainContainerBodyIndex == 2
                                  ? FontWeight.bold
                                  : FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (back!) {
                        Get.back();
                      }
                      controller.handleBottomNavigatorBar(i: 3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset('assets/svg/shopping-cart_3916598.svg',
                            height: 22,
                            color: controller.MainContainerBodyIndex == 3
                                ? AppColors.primary
                                : Colors.grey,
                            semanticsLabel: 'Acme Logo'),
                        Text(
                          'cart'.tr,
                          style: TextStyle(
                              color: controller.MainContainerBodyIndex == 3
                                  ? AppColors.primary
                                  : Colors.grey,
                              fontSize: 14,
                              fontWeight: controller.MainContainerBodyIndex == 3
                                  ? FontWeight.bold
                                  : FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (back!) {
                        Get.back();
                      }
                      controller.handleBottomNavigatorBar(i: 4);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset('assets/svg/grid view.svg',
                            height: 25,
                            color: controller.MainContainerBodyIndex == 4
                                ? AppColors.primary
                                : Colors.grey,
                            semanticsLabel: 'Acme Logo'),
                        Text(
                          'categories'.tr,
                          style: TextStyle(
                              color: controller.MainContainerBodyIndex == 4
                                  ? AppColors.primary
                                  : Colors.grey,
                              fontSize: 14,
                              fontWeight: controller.MainContainerBodyIndex == 4
                                  ? FontWeight.bold
                                  : FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (back!) {
                        Get.back();
                      }
                      controller.handleBottomNavigatorBar(i: 5);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset('assets/svg/heart_3916585.svg',
                            height: 25,
                            color: controller.MainContainerBodyIndex == 5
                                ? AppColors.primary
                                : Colors.grey,
                            semanticsLabel: 'Acme Logo'),
                        Text(
                          'favorite'.tr,
                          style: TextStyle(
                              color: controller.MainContainerBodyIndex == 5
                                  ? AppColors.primary
                                  : Colors.grey,
                              fontSize: 14,
                              fontWeight: controller.MainContainerBodyIndex == 5
                                  ? FontWeight.bold
                                  : FontWeight.w400),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
