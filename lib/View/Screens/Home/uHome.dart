// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/View/Screens/Product/ListAllProudactsView.dart';
import 'package:giftappgp/View/Shared/ImageSlider.dart';
import 'package:giftappgp/View/Widgets/Categories.dart';
import 'package:giftappgp/View/Widgets/Features.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/View/Widgets/ProudactsView.dart';
import 'package:giftappgp/utils/AppColors.dart';

class Uhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
        init: Homecontroller(),
        builder: (controller) => Scaffold(
              key: controller.scaffoldKey,
              //drawer: drawer(),
              backgroundColor: AppColors.grey,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  HomeAppBar(
                    title: 'home'.tr,
                    home: true,
                  ),
                  InkWell(
                    onTap: () {
                      controller.search(context: context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        enabled: false,
                        onChanged: (v) {
                          // controller.orderssearch(v);
                        },
                        decoration: InputDecoration(
                            hintText: 'Search '.tr,
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height - 250,
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ImageSlider(images: [
                              'https://static.vecteezy.com/system/resources/thumbnails/004/299/835/small/online-shopping-on-phone-buy-sell-business-digital-web-banner-application-money-advertising-payment-ecommerce-illustration-search-free-vector.jpg',
                              'https://t3.ftcdn.net/jpg/04/65/46/52/360_F_465465254_1pN9MGrA831idD6zIBL7q8rnZZpUCQTy.jpg'
                            ], height: 100),
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.handleHomeProductsView(i: 1);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: controller.proudctsView == 1
                                            ? AppColors.primary
                                            : null,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'best seller'.tr,
                                      style: TextStyle(
                                          color: controller.proudctsView == 1
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.handleHomeProductsView(i: 2);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: controller.proudctsView == 2
                                            ? AppColors.primary
                                            : null,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'new arrived'.tr,
                                      style: TextStyle(
                                          color: controller.proudctsView == 2
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              endIndent: 70,
                              indent: 70,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ProudactsView(
                              list: controller.proudctsView == 1
                                  ? controller.popularProducts
                                  : controller.latestProducts,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        'shopcategories'.tr,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Divider(
                                      endIndent: Get.width * 0.35,
                                      indent: Get.width * 0.35,
                                      color: Colors.amber,
                                      thickness: 2,
                                    ),
                                    Categories(),
                                    Features(),
                                  ],
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            if (controller.randomcat1 != null)
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller
                                              .categoryList[
                                                  controller.randomcat1!]
                                              .name
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // controller.getProudactByCategory(
                                            //     id: '70');
                                            Get.to(
                                                () => ListAllProudactsView());
                                          },
                                          child: Text(
                                            'seeall'.tr,
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ProudactsView(
                                    list: controller.popularProducts,
                                  ),
                                ],
                              ),
                            if (controller.randomcat2 != null ||
                                controller.randomcat1 != controller.randomcat2)
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          controller
                                              .categoryList[
                                                  controller.randomcat2!]
                                              .name
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // controller.getProudactByCategory(
                                            //     id: '70');
                                            Get.to(
                                                () => ListAllProudactsView());
                                          },
                                          child: Text(
                                            'seeall'.tr,
                                            style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ProudactsView(
                                    list: controller.popularProducts,
                                  ),
                                ],
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            // if (controller.vendors.isNotEmpty)
                            //   Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Container(
                            //         margin: EdgeInsets.all(10),
                            //         padding:
                            //             EdgeInsets.symmetric(horizontal: 10),
                            //         child: Text(
                            //           'allvendors'.tr,
                            //           style: TextStyle(
                            //               color: Colors.black,
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //       Manufacturers(),
                            //     ],
                            //   ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
