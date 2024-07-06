import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/VendorController.dart';
import 'package:giftappgp/View/Screens/Auth/Login.dart';
import 'package:giftappgp/View/Screens/Home/mainContainer.dart';
import 'package:giftappgp/View/Screens/Vendor/vHome.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/View/Widgets/Listitem.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:giftappgp/utils/AppImages.dart';

class vendor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Vendorcontroller>(
        init: Vendorcontroller(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  HomeAppBar(),
                  SizedBox(
                    height: 25,
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0XFFAB6A28),
                    radius: 70,
                    child: CircleAvatar(
                      radius: 67,
                      backgroundImage: AssetImage(AppImages.logo),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      ListItem(
                          title: 'productsmangment'.tr,
                          svgicon: null,
                          iconData: Icons.edit,
                          color: AppColors.primary,
                          ontap: () {
                            Get.to(() => vHome());
                          }),
                      ListItem(
                          title: 'Enter as user'.tr,
                          svgicon: null,
                          color: AppColors.primary,
                          iconData: Icons.person,
                          ontap: () {
                            Get.to(() => MainContainer());
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
                  ))
                ],
              ),
            ));
  }
}
