// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/componantes.dart';
import 'package:giftappgp/utils/AppColors.dart';

class Reviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
        init: Homecontroller(),
        builder: (controller) => Container(
              child: Column(children: [
                customTextFieldWidget(
                    controller: TextEditingController(),
                    title: 'name'.tr,
                    enable: true,
                    iconData: null,
                    IsPass: false,
                    height: 50,
                    require: true,
                    width: Get.width),
                customTextFieldWidget(
                    controller: TextEditingController(),
                    title: 'addcomment'.tr,
                    enable: true,
                    height: 150,
                    maxline: 5,
                    iconData: null,
                    require: true,
                    IsPass: false,
                    width: Get.width),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'rate'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '*',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemSize: 30,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 5,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                button(
                    color: AppColors.primary,
                    title: 'confirm'.tr,
                    fontsize: 17,
                    fontColor: Colors.white,
                    height: 50,
                    function: () {},
                    width: Get.width)
              ]),
            ));
  }
}
