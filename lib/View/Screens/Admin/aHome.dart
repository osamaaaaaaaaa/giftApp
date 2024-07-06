// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AdminController.dart';
import 'package:giftappgp/View/Screens/Admin/aordersList.dart';
import 'package:giftappgp/View/Screens/Admin/aproductList.dart';
import 'package:giftappgp/View/Screens/Admin/ausersList.dart';
import 'package:giftappgp/View/Screens/Admin/acategories.dart';
import 'package:giftappgp/View/Screens/Auth/Login.dart';
import 'package:giftappgp/View/Shared/customtopAppBar.dart';
import 'package:giftappgp/View/Widgets/Listitem.dart';
import 'package:giftappgp/utils/AppColors.dart';

class aHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Admincontroller>(
        init: Admincontroller(),
        builder: (controller) => Scaffold(
              body: Column(
                children: [
                  customTopAppBar(title: 'home'.tr, back: false),
                  SizedBox(
                    height: 50,
                  ),
                  ListItem(
                      title: 'productsmangment'.tr,
                      svgicon: null,
                      iconData: Icons.edit,
                      color: AppColors.primary,
                      ontap: () {
                        Get.to(() => Aproductlist());
                      }),
                  ListItem(
                      title: 'orders'.tr,
                      svgicon: null,
                      color: AppColors.primary,
                      iconData: Icons.request_page,
                      ontap: () {
                        Get.to(() => Aorderslist());
                      }),
                  ListItem(
                      title: 'categories'.tr,
                      svgicon: null,
                      color: AppColors.primary,
                      iconData: Icons.category,
                      ontap: () {
                        Get.to(() => acategories());
                      }),
                  ListItem(
                      title: 'users'.tr,
                      svgicon: null,
                      color: AppColors.primary,
                      iconData: Icons.person,
                      ontap: () {
                        Get.to(() => ausersList());
                      }),
                  ListItem(
                      title: 'logout'.tr,
                      svgicon: null,
                      iconData: Icons.logout,
                      color: Colors.red,
                      ontap: () {
                        Get.offAll(() => Login());
                      }),
                ],
              ),
            ));
  }
}

Widget _item(
        {required String icon,
        required String title,
        required Function() ontap}) =>
    InkWell(
        onTap: ontap,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.2),
              radius: 35,
              child: SvgPicture.asset(
                icon,
                color: AppColors.primary,
                width: 40,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(title)
          ],
        ));
