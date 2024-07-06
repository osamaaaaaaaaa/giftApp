// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:giftappgp/Controllers/ProfileController.dart';
import 'package:giftappgp/Helper/valied_input.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/componantes.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';

class EditProfile extends StatelessWidget {
  var formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.grey,
              // bottomNavigationBar: BottomApp_Bar(back: true),
              body: SingleChildScrollView(
                child: Form(
                  key: formstate,
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
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  //   alignment: Alignment.centerRight,
                                  padding: EdgeInsets.all(10),
                                  width: Get.width,
                                  constraints:
                                      BoxConstraints(maxWidth: Get.width),
                                  child: Text(
                                    'profileinfo'.tr,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                              customTextFieldWidget(
                                  controller: controller.firstNameController,
                                  title: 'name'.tr,
                                  enable: true,
                                  iconData: Icons.person,
                                  IsPass: false,
                                  height: 50,
                                  require: true,
                                  width: Get.width),
                              SizedBox(
                                height: 16,
                              ),
                              customTextFieldWidget(
                                  controller: controller.emailController,
                                  title: 'email address'.tr,
                                  enable: true,
                                  iconData: Icons.mail,
                                  IsPass: false,
                                  height: 50,
                                  require: true,
                                  validator: (v) {
                                    return validInput(v!, 5, 100, "email");
                                  },
                                  width: Get.width),
                              SizedBox(
                                height: 16,
                              ),
                              customTextFieldWidget(
                                  controller: controller.mobileController,
                                  title: 'phone number'.tr,
                                  enable: true,
                                  Isnumber: true,
                                  validator: (v) {
                                    return validInput(v!, 5, 100, "mobile");
                                  },
                                  iconData: Icons.mobile_friendly,
                                  IsPass: false,
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
                                    if (formstate.currentState!.validate()) {
                                      controller.editUser();
                                    }
                                  },
                                  border: 15,
                                  width: Get.width)
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ));
  }
}
