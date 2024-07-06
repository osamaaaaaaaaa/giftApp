// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AdminController.dart';
import 'package:giftappgp/Helper/valied_input.dart';
import 'package:giftappgp/Models/CategoryModel.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/ImageNetwork.dart';
import 'package:giftappgp/View/Shared/componantes.dart';
import 'package:giftappgp/View/Shared/customtopAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';

class Acatmange extends StatelessWidget {
  CatrgoryModel? catrgoryModel;
  Acatmange({this.catrgoryModel}) {
    if (catrgoryModel != null) {
      catnam.text = catrgoryModel!.name.toString();
    }
  }
  var catnam = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formstate = GlobalKey<FormState>();
    return GetBuilder<Admincontroller>(
        init: Admincontroller(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      customTopAppBar(title: 'categories'.tr),
                      SizedBox(
                        height: 20,
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
                              height: 120,
                              width: 120,
                              child: Container(
                                alignment: Alignment.center,
                                child: controller.imageurl != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: ImageNetwork(
                                          src: controller.imageurl.toString(),
                                          height: 120,
                                          width: 120,
                                        ))
                                    : Icon(
                                        Icons.add_a_photo,
                                        size: 20,
                                        color: AppColors.primary,
                                      ),
                              )),
                        ),
                      ),
                      customTextFieldWidget(
                          controller: catnam,
                          title: 'name'.tr,
                          enable: true,
                          iconData: null,
                          validator: (v) {
                            return validInput(v.toString(), 1, 250, '');
                          },
                          IsPass: false,
                          height: 50,
                          width: Get.width),
                      button(
                          color: AppColors.primary,
                          title: 'save'.tr,
                          fontsize: 15,
                          fontColor: Colors.white,
                          height: 50,
                          function: () {
                            if (formstate.currentState!.validate()) {
                              if (catrgoryModel == null) {
                                controller.addnewCategory(
                                    model: CatrgoryModel(
                                        name: catnam.text,
                                        image: controller.imageurl));
                              } else {
                                catrgoryModel?.name = catnam.text;
                                catrgoryModel?.image = controller.imageurl;
                                controller.editCategory(model: catrgoryModel!);
                              }
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
