// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/Models/productModel.dart';
import 'package:giftappgp/View/Screens/Product/ProductDetails.dart';
import 'package:giftappgp/View/Shared/ImageNetwork.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:giftappgp/utils/AppImages.dart';

class ProudactsView extends StatelessWidget {
  List<ProudactsModel> list = [];
  ProudactsView({required this.list});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
        init: Homecontroller(),
        builder: (controller) => SizedBox(
              height: 360,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (
                  context,
                  index,
                ) =>
                    Container(
                  width: Get.width * 0.49,
                  margin: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.1),
                      color: Colors.white),
                  child: InkWell(
                    onTap: () {
                      controller.productcartquntity = 1;

                      Get.to(() => ProductDetails(proudactsModel: list[index]));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: list[index].thumb == null
                              ? Image.asset(
                                  AppImages.noimage,
                                  height: 200,
                                  width: 220,
                                )
                              : ImageNetwork(
                                  width: Get.width * 0.5,
                                  height: 220,
                                  src: list[index].thumb.toString()),
                        ),
                        Container(
                          //    alignment: Alignment.centerRight,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          constraints: BoxConstraints(maxWidth: 250),
                          child: Text(
                            list[index].name.toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          constraints: BoxConstraints(maxWidth: 250),
                          child: Text(
                            list[index].price.toString() + 'le'.tr,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.addToCart(
                                    quntity: 1,
                                    productId: list[index].productId);
                              },
                              child: Container(
                                  //  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 0.8),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: AppColors.primary,
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                controller.addTofav(
                                    quntity: 1,
                                    productId: list[index].productId);
                              },
                              child: Container(
                                  //  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 0.8),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Icon(
                                    Icons.favorite,
                                    color: AppColors.red,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
