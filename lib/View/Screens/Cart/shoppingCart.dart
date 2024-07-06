// ignore_for_file: use_key_in_widget_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/cartController.dart';
import 'package:giftappgp/View/Screens/Cart/checkout.dart';
import 'package:giftappgp/View/Shared/ImageNetwork.dart';
import 'package:giftappgp/View/Shared/Loading.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/View/Widgets/noDataAvaliable.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:giftappgp/utils/AppImages.dart';

class Shoppingcart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Cartcontroller>(
        init: Cartcontroller(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: controller.cartLoding
                  ? Loading()
                  : controller.cartList.isEmpty
                      ? Center(
                          child: empty(),
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            HomeAppBar(
                              home: true,
                              title: 'cart'.tr,
                            ),
                            Expanded(
                                child: ListView.builder(
                                    itemCount: controller.cartList.length,
                                    itemBuilder: (context, i) => Container(
                                        child: _cart(
                                            controller: controller,
                                            carindex: i)))),
                            if (controller.cartList.isNotEmpty)
                              InkWell(
                                onTap: () {
                                  Get.to(() => checkout());
                                },
                                child: Container(
                                  color: AppColors.grey,
                                  padding: EdgeInsets.all(20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.primary,
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: Get.width - 120,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'goToCheckout'.tr +
                                                    ' ' +
                                                    '(${controller.totalCartPrice().toString() + 'le'.tr})',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.shopping_cart_checkout,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
            ));
  }
}

Widget _cart({required Cartcontroller controller, required int carindex}) {
  var prod =
      controller.getProductById(id: controller.cartList[carindex].productId);
  if (prod != null) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              prod.thumb != null
                  ? ImageNetwork(
                      src: prod.thumb.toString(), height: 80, width: 80)
                  : Image.asset(
                      AppImages.noimage,
                      height: 80,
                      width: 80,
                    ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: Get.width - 200),
                    child: Text(
                      prod.name.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    //color: Colors.amber,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(
                        //   maxHeight: 60,
                        maxWidth: Get.width - 200),
                    child: Text(
                      prod.description.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    '${controller.cartList[carindex].quntity}x',
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      controller
                          .removeFromCart(controller.cartList[carindex].id);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                    ((prod.price)! * (controller.cartList[carindex].quntity!))
                            .toString() +
                        'le'.tr),
              )
            ],
          )
        ],
      ),
    );
  } else {
    return Container();
  }
}
