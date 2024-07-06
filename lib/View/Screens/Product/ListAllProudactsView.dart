// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/View/Shared/ImageNetwork.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/View/Widgets/noDataAvaliable.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:giftappgp/utils/AppImages.dart';

class ListAllProudactsView extends StatelessWidget {
  bool? isfav;
  ListAllProudactsView({this.isfav});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
      init: Homecontroller(),
      builder: (controller) => Scaffold(
        //bottomNavigationBar: BottomApp_Bar(back: true),
        body:
            //  controller.ListAllProudactsLoading
            //     ? Loading()
            //     :
            controller.ListAllProudacts.isEmpty
                ? Center(child: empty())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      HomeAppBar(),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: Get.height - 200,
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 0.4),
                            itemCount: controller.ListAllProudacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 0.1),
                                    color: Colors.white),
                                child: InkWell(
                                  onTap: () {
                                    // controller.productcartquntity = 1;
                                    // controller.getProudactById(
                                    //     proudactId: controller
                                    //         .ListAllProudacts[index].productId);
                                    // Get.to(() => ProductDetails(
                                    //     proudactsModel: controller
                                    //         .ListAllProudacts[index]));
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      isfav == true
                                          ? InkWell(
                                              onTap: () {
                                                // controller.removefromfav(
                                                //     id: controller
                                                //         .ListAllProudacts[index]
                                                //         .productId);
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.white,
                                                  )),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                // controller.addTofav(
                                                //     id: controller
                                                //         .ListAllProudacts[index]
                                                //         .productId);
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  child: Icon(
                                                      Icons.favorite_border)),
                                            ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: controller
                                                    .ListAllProudacts[index]
                                                    .thumb ==
                                                ""
                                            ? Image.asset(
                                                AppImages.noimage,
                                                height: 200,
                                                width: Get.width * 0.5,
                                              )
                                            : controller.ListAllProudacts[index]
                                                        .thumb ==
                                                    null
                                                ? Image.asset(
                                                    AppImages.noimage,
                                                    height: 200,
                                                    width: Get.width * 0.5,
                                                  )
                                                : ImageNetwork(
                                                    width: 250,
                                                    height: 220,
                                                    src: controller
                                                        .ListAllProudacts[index]
                                                        .thumb
                                                        .toString()),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.all(10),
                                        constraints:
                                            BoxConstraints(maxWidth: 250),
                                        child: Text(
                                          controller
                                              .ListAllProudacts[index].name
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        margin: EdgeInsets.all(10),
                                        constraints:
                                            BoxConstraints(maxWidth: 250),
                                        child: Text(
                                          controller
                                              .ListAllProudacts[index].price
                                              .toString(),
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // Container(
                                      //   // width: 170,
                                      //   child: InkWell(
                                      //     onTap: () {
                                      //       controller.addToCart(
                                      //           id: controller
                                      //               .ListAllProudacts[index]
                                      //               .productId);
                                      //     },
                                      //     child: Container(
                                      //       margin: EdgeInsets.all(5),
                                      //       alignment: Alignment.center,
                                      //       padding: EdgeInsets.symmetric(
                                      //           horizontal: 5, vertical: 5),
                                      //       decoration: BoxDecoration(
                                      //           boxShadow: [
                                      //             BoxShadow(
                                      //                 color: Colors.blueGrey,
                                      //                 blurRadius: 1),
                                      //           ],
                                      //           color: Colors.white,
                                      //           borderRadius:
                                      //               BorderRadius.circular(15)),
                                      //       child: Row(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment.center,
                                      //         children: [
                                      //           Icon(Icons
                                      //               .add_shopping_cart_sharp),
                                      //           SizedBox(
                                      //             width: 5,
                                      //           ),
                                      //           Text(
                                      //             'add to cart'.tr,
                                      //             style: TextStyle(
                                      //                 fontSize: 14,
                                      //                 color: Colors.grey,
                                      //                 fontWeight:
                                      //                     FontWeight.w400),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
      ),
    );
  }
}
