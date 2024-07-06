// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/ProfileController.dart';
import 'package:giftappgp/View/Screens/Auth/Login.dart';
import 'package:giftappgp/View/Screens/Cart/orders.dart';
import 'package:giftappgp/View/Screens/Profile/Screens/AddressList.dart';
import 'package:giftappgp/View/Screens/Profile/Screens/EditPassword.dart';
import 'package:giftappgp/View/Screens/Profile/Screens/EditProfile.dart';
import 'package:giftappgp/View/Screens/Profile/Shared/profileContainer.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:giftappgp/utils/AppIcons.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  HomeAppBar(
                    home: true,
                    title: 'profile'.tr,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.selectimage();
                          },
                          child: Center(
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border:
                                        Border.all(color: AppColors.primary)),
                                height: 80,
                                width: 80,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: controller.url != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            controller.url.toString(),
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ))
                                      : Icon(
                                          Icons.add_a_photo,
                                          size: 20,
                                          color: AppColors.primary,
                                        ),
                                )),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (controller.userinfo != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                controller.userinfo!.name.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                controller.userinfo!.email.toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    children: [
                      ProfileContainer(
                          fun: () {
                            Get.to(() => EditProfile());
                          },
                          title: 'editprofile'.tr,
                          assetName: Appicons.edit),
                      ProfileContainer(
                          fun: () {
                            Get.to(() => EditPassword());
                          },
                          title: 'editpassword'.tr,
                          assetName: Appicons.lock),
                      ProfileContainer(
                          fun: () {
                            controller.fetchAddress();
                            Get.to(() => AddressList());
                          },
                          title: 'editadress'.tr,
                          assetName: Appicons.id),
                      ProfileContainer(
                          fun: () {
                            Get.to(() => Orders());
                          },
                          title: 'myorders'.tr,
                          assetName: Appicons.orders),
                      ProfileContainer(
                          fun: () async {
                            await launchUrl(Uri.parse("tel:+201142107502"));
                          },
                          // trailing: Icon(Icons.phone_callback_outlined),
                          title: 'Contact us',
                          // title: 'myorders'.tr,
                          assetName: Appicons.mail),
                      ProfileContainer(
                          fun: () {
                            // controller.LogOut();
                            Get.offAll(Login());
                          },
                          title: 'logout'.tr,
                          assetName: Appicons.returN),
                    ],
                  ))
                ],
              ),
            ));
  }
}
