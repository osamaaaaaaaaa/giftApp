// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:giftappgp/utils/AppImages.dart';

class HomeAppBar extends StatelessWidget {
  bool? home;
  bool? drawer;
  String? title;
  HomeAppBar({this.home, this.drawer, this.title});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
        init: Homecontroller(),
        builder: (controller) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
              ),
              padding: EdgeInsets.all(8),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (drawer == true)
                        InkWell(
                          onTap: () {
                            // controller.opendrawe();
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primary),
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.table_rows_sharp,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                        ),
                      SizedBox(
                        width: 5,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(AppImages.logo)),
                    ],
                  ),
                  if (title != null)
                    Text(
                      '$title',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  home != true
                      ? InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Get.locale.toString() == 'en'
                                ? Icons.arrow_forward
                                : Icons.arrow_forward,
                            size: 30,
                            color: AppColors.primary,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            // controller.search(context: context);
                          },
                          child: Icon(
                            null,
                            size: 30,
                            color: AppColors.primary,
                          ),
                        ),
                ],
              ),
            ));
  }
}
