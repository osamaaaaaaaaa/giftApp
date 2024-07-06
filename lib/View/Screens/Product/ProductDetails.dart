// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/Models/productModel.dart';
import 'package:giftappgp/View/Screens/Product/ProudactFeatures.dart';
import 'package:giftappgp/View/Screens/Product/Reviews.dart';
import 'package:giftappgp/View/Shared/ImageSlider.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/View/Widgets/ProudactsView.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatelessWidget {
  ProudactsModel? proudactsModel;
  ProductDetails({required this.proudactsModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
        init: Homecontroller(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    HomeAppBar(),
                    SizedBox(
                      height: Get.height - 250,
                      child: ListView(
                        children: [
                          Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                if (proudactsModel?.additional_images != null ||
                                    proudactsModel!
                                        .additional_images!.isNotEmpty)
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: ImageSlider(
                                        images:
                                            proudactsModel!.additional_images!,
                                        height: 250),
                                  ),
                                Container(
                                  //    color: Colors.amber,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),

                                      Container(
                                        width: Get.width,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          proudactsModel!.price.toString() +
                                              'le'.tr,
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      //Prudacts Description
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 15),
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 0.1, color: Colors.grey),
                                            color: AppColors.grey
                                                .withOpacity(0.8)),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: Get.width * 0.9),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: Colors.grey,
                                                    size: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth:
                                                            Get.width * 0.9),
                                                    child: Text(
                                                      proudactsModel!.name
                                                          .toString(),
                                                      style: TextStyle(
                                                          // color:
                                                          //     Colors.grey,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            proudactsModel!.vendorId == null
                                                ? Container()
                                                : FutureBuilder(
                                                    future: controller.getvendor(
                                                        userid: proudactsModel
                                                            ?.vendorId
                                                            .toString()),
                                                    builder:
                                                        (context, snapshot) =>
                                                            Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth:
                                                                  Get.width *
                                                                      0.9),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.circle,
                                                            color: Colors.grey,
                                                            size: 10,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            constraints:
                                                                BoxConstraints(
                                                                    maxWidth:
                                                                        Get.width *
                                                                            0.9),
                                                            child: Text(
                                                              '${snapshot.data?.vendorname.toString()}',
                                                              style: TextStyle(
                                                                  // color: AppColors
                                                                  //     .primary,

                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: Get.width * 0.9),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: Colors.grey,
                                                    size: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth:
                                                            Get.width * 0.9),
                                                    child: Text(
                                                      proudactsModel!
                                                                  .quantity !=
                                                              0
                                                          ? 'avaliable'.tr
                                                          : "unavaliable",
                                                      style: TextStyle(
                                                          color: proudactsModel!
                                                                      .quantity !=
                                                                  0
                                                              ? Colors.green
                                                              : Colors.red,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            // Container(
                                            //   constraints: BoxConstraints(
                                            //       maxWidth:
                                            //           Get.width * 0.9),
                                            //   child: ReadMoreText(
                                            //     trimLines: 2,
                                            //     colorClickableText:
                                            //         AppColors.primary,
                                            //     trimMode: TrimMode.Line,
                                            //     trimCollapsedText:
                                            //         'Show more'.tr,
                                            //     trimExpandedText:
                                            //         'Show less'.tr,
                                            //     proudactsModel!
                                            //         .description
                                            //         .toString(),
                                            //     style: TextStyle(
                                            //         color: Colors.grey,
                                            //         fontSize: 15,
                                            //         fontWeight:
                                            //             FontWeight.bold),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 0.1, color: Colors.grey),
                                      color: AppColors.grey.withOpacity(0.8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller
                                              .handleProudactDestailsOpinionView(
                                                  i: 1);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                              color: controller
                                                          .ProudactDestailsOpinionView ==
                                                      1
                                                  ? AppColors.primary
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Text(
                                            'details'.tr,
                                            style: TextStyle(
                                                color: controller
                                                            .ProudactDestailsOpinionView ==
                                                        1
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller
                                              .handleProudactDestailsOpinionView(
                                                  i: 2);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                              color: controller
                                                          .ProudactDestailsOpinionView ==
                                                      2
                                                  ? AppColors.primary
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Text(
                                            'opinion'.tr,
                                            style: TextStyle(
                                                color: controller
                                                            .ProudactDestailsOpinionView ==
                                                        2
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                controller.ProudactDestailsOpinionView == 1
                                    ? Container(
                                        padding: EdgeInsets.all(10),
                                        constraints: BoxConstraints(
                                            maxWidth: Get.width * 0.9),
                                        child: ReadMoreText(
                                          trimLines: 2,
                                          colorClickableText: AppColors.primary,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'Show more'.tr,
                                          trimExpandedText: 'Show less'.tr,
                                          proudactsModel!.description
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Reviews(),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                ProudactFeatures(),
                                if (controller.allproducts
                                    .where((e) =>
                                        e.categoryId ==
                                        proudactsModel?.categoryId)
                                    .toList()
                                    .isNotEmpty)
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    color: AppColors.grey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(10),
                                            child: Text(
                                              'you may also like'.tr,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        ProudactsView(
                                            list: controller.allproducts
                                                .where((e) =>
                                                    e.categoryId ==
                                                    proudactsModel?.categoryId)
                                                .toList()),
                                      ],
                                    ),
                                  ),
                              ]),
                        ],
                      ),
                    ),
                    Container(
                      color: AppColors.grey,
                      padding: EdgeInsets.all(20),
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width - 130,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.IncreaseDeacreaseQuntity(
                                          ispositive: false);
                                    },
                                    child: _quntityControllerWidget(
                                        iconData: Icons.remove),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    controller.productcartquntity.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.IncreaseDeacreaseQuntity(
                                          ispositive: true);
                                    },
                                    child: _quntityControllerWidget(
                                        iconData: Icons.add),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.addToCart(
                                    productId: proudactsModel?.productId);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(5)),
                                child: SvgPicture.asset(
                                  'assets/svg/shopping-cart_3916598.svg',
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

Widget _quntityControllerWidget({required IconData iconData}) => Container(
      padding: EdgeInsets.all(2),
      child: Icon(
        iconData,
        color: Colors.black,
        size: 22,
      ),
    );
