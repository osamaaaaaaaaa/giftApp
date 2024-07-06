// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/View/Shared/ImageNetwork.dart';
import 'package:giftappgp/utils/AppImages.dart';

class Manufacturers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
        init: Homecontroller(),
        builder: (controller) => SizedBox(
              height: 175,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.vendors.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          // controller.getProudactByManufacters(
                          //     id: controller
                          //         .ManufacturerList[index].manufacturerId);
                          // Get.to(() => ListAllProudactsView());
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              height: 150,
                              width: Get.width * 0.4,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: controller.vendors[index].image == null
                                  ? Image.asset(
                                      AppImages.noimage,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : ImageNetwork(
                                      height: 100,
                                      width: 100,
                                      src: controller.vendors[index].image
                                          .toString()),
                            ),
                          ],
                        ),
                      )),
            ));
  }
}
