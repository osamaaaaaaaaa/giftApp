// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AuthController.dart';
import 'package:giftappgp/Helper/valied_input.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/CustomTextField.dart';
import 'package:giftappgp/utils/AppColors.dart';

class Resetpassword extends StatelessWidget {
  var email = TextEditingController();
  var _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Authcontroller>(
        init: Authcontroller(),
        builder: (controller) => Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Container(
                    height: Get.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "39".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          ),
                        ),
                        SizedBox(
                          height: 20,
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
                        button(
                            color: AppColors.primary,
                            title: 'continue'.tr,
                            fontsize: 15,
                            fontColor: Colors.white,
                            height: 50,
                            border: 25,
                            function: () {
                              if (_formkey.currentState!.validate()) {
                                controller.restorePassword(
                                  email: email.text,
                                );
                              }
                            },
                            width: Get.width),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
