// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/View/Screens/Product/ListAllProudactsView.dart';
import 'package:giftappgp/View/Shared/ImageNetwork.dart';
import 'package:giftappgp/utils/AppImages.dart';

class Categories extends StatelessWidget {
  // final CarouselController controllerr = CarouselController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
        init: Homecontroller(),
        builder: (controller) => SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoryList.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    controller.getprodByCategory(
                        catid: controller.categoryList[index].categoryId);
                    Get.to(() => ListAllProudactsView());
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        //   boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
                        color: Colors.white),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: controller.categoryList[index].image == ""
                              ? Image.asset(
                                  AppImages.noimage,
                                  height: Get.width * 0.3,
                                  width: Get.width * 0.3,
                                )
                              : ImageNetwork(
                                  height: Get.width * 0.3,
                                  width: Get.width * 0.3,
                                  src: controller.categoryList[index].image
                                      .toString()),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          controller.categoryList[index].name.toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
