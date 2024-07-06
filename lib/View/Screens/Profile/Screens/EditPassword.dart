// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/ProfileController.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/componantes.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';

class EditPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) => Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    HomeAppBar(),
                    Container(
                        padding: EdgeInsets.all(10),
                        height: Get.height - 150,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                width: Get.width,
                                decoration:
                                    BoxDecoration(color: AppColors.grey),
                                constraints:
                                    BoxConstraints(maxWidth: Get.width),
                                child: Text(
                                  'editpassword'.tr,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                // alignment: Alignment.centerRight,
                                padding: EdgeInsets.all(10),
                                width: Get.width,
                                constraints:
                                    BoxConstraints(maxWidth: Get.width),
                                child: Text(
                                  'password'.tr,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            customTextFieldWidget(
                                controller: controller.newPassController,
                                title: 'newpassword'.tr,
                                enable: true,
                                iconData: Icons.lock,
                                IsPass: true,
                                height: 50,
                                require: true,
                                width: Get.width),
                            SizedBox(
                              height: 16,
                            ),
                            customTextFieldWidget(
                                controller: controller.confirmNewPassController,
                                title: '${'confirm'.tr} ${'newpassword'.tr}',
                                enable: true,
                                iconData: Icons.lock,
                                IsPass: true,
                                height: 50,
                                require: true,
                                width: Get.width),
                            SizedBox(
                              height: 16,
                            ),
                            button(
                                color: Colors.white,
                                title: 'back'.tr,
                                fontsize: 17,
                                fontColor: Colors.grey,
                                height: 40,
                                function: () {
                                  Get.back();
                                },
                                border: 15,
                                borderColor: Colors.grey,
                                width: Get.width),
                            button(
                                color: AppColors.primary,
                                title: 'continue'.tr,
                                fontsize: 17,
                                fontColor: Colors.white,
                                height: 40,
                                function: () {
                                  if (controller.newPassController.text ==
                                      controller
                                          .confirmNewPassController.text) {
                                    controller.changePassword();
                                  } else {
                                    Apphelper.errorsnackbar('error');
                                  }
                                },
                                border: 15,
                                width: Get.width)
                          ],
                        ))
                  ],
                ),
              ),
            ));
  }
}
