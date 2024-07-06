// ignore_for_file: prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AuthController.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/Helper/valied_input.dart';
import 'package:giftappgp/Models/userModel.dart';
import 'package:giftappgp/Services/StorageKeys.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/CustomTextField.dart';
import 'package:giftappgp/utils/AppColors.dart';

class Register extends StatelessWidget {
  bool seller = false;
  Register({required this.seller});
  var name = TextEditingController();
  var vendorname = TextEditingController();
  var mobile = TextEditingController();
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
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        controller.selectimage();
                      },
                      child: Center(
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: AppColors.primary)),
                            height: 200,
                            width: 200,
                            child: Container(
                              alignment: Alignment.center,
                              child: controller.url != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        controller.url.toString(),
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ))
                                  : Icon(
                                      Icons.add_a_photo,
                                      size: 50,
                                      color: AppColors.primary,
                                    ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    if (seller)
                      CustomTextField(
                        isNumber: false,
                        valid: (val) {
                          return validInput(val!, 5, 100, "name");
                        },
                        myController: vendorname,
                        hintText: "entervenorname".tr,
                        iconData: Icons.person,
                        labelText: "vendorname".tr,
                      ),
                    CustomTextField(
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 5, 100, "name");
                      },
                      myController: name,
                      hintText: "23".tr,
                      iconData: Icons.person,
                      labelText: "20".tr,
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
                    CustomTextField(
                      isNumber: false,
                      valid: (val) {
                        return validInput(val!, 5, 100, "mobile");
                      },
                      myController: mobile,
                      hintText: "22".tr,
                      iconData: Icons.call,
                      labelText: "21".tr,
                    ),
                    controller.authLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : button(
                            color: AppColors.primary,
                            title: 'register'.tr,
                            fontsize: 15,
                            fontColor: Colors.white,
                            height: 50,
                            border: 25,
                            function: () {
                              if (controller.url == null && seller) {
                                Apphelper.errorsnackbar('please add photo');
                                return;
                              }
                              if (_formkey.currentState!.validate()) {
                                controller.signup(
                                    model: userModel(
                                  image: controller.url,
                                  mobile: mobile.text,
                                  roleId: seller
                                      ? Storagekeys.vendor
                                      : Storagekeys.user,
                                  name: name.text,
                                  pass: pass.text,
                                  email: email.text,
                                  vendorname: vendorname.text,
                                  createdAt: DateTime.now().toString(),
                                ));
                              }
                            },
                            width: Get.width)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
