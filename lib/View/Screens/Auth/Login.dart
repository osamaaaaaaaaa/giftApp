// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AuthController.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/Helper/valied_input.dart';
import 'package:giftappgp/View/Screens/Admin/aHome.dart';
import 'package:giftappgp/View/Screens/Auth/Register.dart';
import 'package:giftappgp/View/Screens/Auth/ResetPassword.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/CustomTextField.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:giftappgp/utils/AppImages.dart';

class Login extends StatelessWidget {
  var email = TextEditingController();
  var pass = TextEditingController();
  var _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Authcontroller>(
        init: Authcontroller(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        if (Get.locale.toString() == 'en') {
                          Get.updateLocale(Locale('ar'));
                        } else {
                          Get.updateLocale(Locale('en'));
                        }
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            Apphelper().getLang() == 1 ? 'ع' : 'En',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
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
                      height: 80,
                    ),
                    CustomTextField(
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 5, 100, "email");
                      },
                      myController: email,
                      hintText: "12".tr,
                      iconData: Icons.email_outlined,
                      labelText: "18".tr,
                    ),
                    CustomTextField(
                      isNumber: false,
                      onTapIcon: () {
                        //  controller.showPassword();
                      },
                      valid: (val) {
                        return validInput(val!, 3, 30, "password");
                      },
                      obscureText: true,
                      myController: pass,
                      hintText: "13".tr,
                      iconData: Icons.lock_outline,
                      labelText: "19".tr,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => Resetpassword());
                      },
                      child: Text(
                        "14".tr,
                        textAlign: TextAlign.right,
                      ),
                    ),
                    controller.authLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : button(
                            color: AppColors.primary,
                            title: '26'.tr,
                            fontsize: 15,
                            fontColor: Colors.white,
                            height: 50,
                            border: 25,
                            function: () {
                              if (_formkey.currentState!.validate()) {
                                if (email.text == 'admin@admin.com'.trim() &&
                                    pass.text == '123123122') {
                                  Get.offAll(() => aHome());
                                  return;
                                }
                                controller.signin(
                                    email: email.text, pass: pass.text);
                              }
                            },
                            width: Get.width),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('16'.tr),
                        InkWell(
                          onTap: () {
                            Get.to(() => Register(
                                  seller: false,
                                ));
                          },
                          child: Text('17'.tr,
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => Register(
                              seller: true,
                            ));
                      },
                      child: Text('joinus'.tr,
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
