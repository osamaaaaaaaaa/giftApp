import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/ProfileController.dart';
import 'package:giftappgp/Helper/valied_input.dart';
import 'package:giftappgp/Models/addressModel.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/componantes.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';

class addressForm extends StatelessWidget {
  var formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      HomeAppBar(),
                      SizedBox(
                        height: 50,
                      ),
                      customTextFieldWidget(
                          controller: controller.mobileController,
                          title: 'mobile'.tr,
                          enable: true,
                          iconData: Icons.call,
                          IsPass: false,
                          validator: (v) {
                            return validInput(v.toString(), 1, 120, 'phone');
                          },
                          height: 50,
                          require: true,
                          width: Get.width),
                      SizedBox(
                        height: 10,
                      ),
                      customTextFieldWidget(
                          controller: controller.city,
                          title: 'city'.tr,
                          enable: true,
                          iconData: Icons.person,
                          IsPass: false,
                          height: 50,
                          validator: (v) {
                            return validInput(v.toString(), 1, 120, 'type');
                          },
                          require: true,
                          width: Get.width),
                      SizedBox(
                        height: 10,
                      ),
                      customTextFieldWidget(
                          controller: controller.address1controller,
                          title: 'street'.tr,
                          enable: true,
                          iconData: Icons.add_location_alt,
                          IsPass: false,
                          height: 80,
                          maxline: 3,
                          validator: (v) {
                            return validInput(v.toString(), 1, 120, 'type');
                          },
                          require: true,
                          width: Get.width),
                      button(
                          color: AppColors.primary,
                          title: 'save'.tr,
                          fontsize: 16,
                          fontColor: Colors.white,
                          height: 50,
                          function: () {
                            if (formstate.currentState!.validate()) {
                              controller.addNewAddress(
                                  model: addressModel(
                                      userId: controller.user,
                                      city: controller.city.text,
                                      street:
                                          controller.address1controller.text,
                                      mobile: controller.mobileController.text,
                                      latitude: controller.latLng?.latitude,
                                      longitude: controller.latLng?.longitude));
                            }
                          },
                          width: Get.width)
                    ],
                  ),
                ),
              ),
            ));
  }
}
