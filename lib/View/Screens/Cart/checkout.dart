// ignore_for_file: prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/cartController.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/Models/addressModel.dart';
import 'package:giftappgp/Models/orderModel.dart';
import 'package:giftappgp/View/Screens/Cart/cartaddressmap.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class checkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Cartcontroller>(
        init: Cartcontroller(),
        builder: (controller) => Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  height: Get.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          HomeAppBar(),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'shipto'.tr,
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _address(controller: controller),
                          SizedBox(
                              height: 250,
                              width: Get.width,
                              child: cartaddressmap()),
                        ],
                      ),
                      Column(
                        children: [
                          _widget(
                              title: 'subtotal'.tr,
                              subtitle:
                                  '${controller.totalCartPrice()}${'le'.tr}'),
                          _widget(
                              title: 'shipping'.tr,
                              subtitle: controller.totalCartPrice() > 250
                                  ? 0.toString() + 'le'.tr
                                  : 50.toString() + 'le'.tr),
                          _widget(
                            title: 'total'.tr,
                            subtitle: controller.totalCartPrice() > 250
                                ? (controller.totalCartPrice() + 0).toString() +
                                    'le'.tr
                                : (controller.totalCartPrice() + 50)
                                        .toString() +
                                    'le'.tr,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.customeraddressmodel.latitude ==
                              null) {
                            Apphelper.errorsnackbar('add address');
                            controller.fetchAddress();

                            return;
                          } else {
                            Get.defaultDialog(
                                title: '',
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.addNewOrder(
                                            model: orderModel(
                                                createdAt:
                                                    DateTime.now().toString(),
                                                address: controller
                                                    .customeraddressmodel,
                                                userid: controller.user,
                                                price:
                                                    controller.totalCartPrice(),
                                                items: [
                                                  for (var e
                                                      in controller.cartList)
                                                    e.toJson()
                                                ],
                                                status: 0));
                                      },
                                      child: Column(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Icon(Icons.money),
                                          Text('Cash')
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Get.back();
                                        // controller.makePayment(
                                        //   context,
                                        //   amount: 5000,
                                        //   planId: 1,
                                        // );
                                      },
                                      child: Column(
                                        children: [
                                          Icon(Icons.branding_watermark),
                                          Text('Visa')
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          }
                        },
                        child: Container(
                          color: AppColors.grey,
                          padding: EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.primary),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: Get.width - 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'place order'.tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.shopping_cart_checkout_rounded,
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
                ),
              ),
            ));
  }
}

Widget _widget({required String title, required String subtitle}) => Container(
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: Text(
                '${title} :',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              )),
          Container(
              margin: EdgeInsets.all(5),
              child: Text(
                '${subtitle}',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ))
        ],
      ),
    );

Widget _address({
  required Cartcontroller controller,
}) =>
    Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<addressModel>(
          isExpanded: true,
          hint: Row(
            children: [
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  controller.customeraddressmodel.street.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: controller.addressList
              .map((addressModel item) => DropdownMenuItem<addressModel>(
                    value: item,
                    child: Text(
                      '${item.street?.toString()},${item.city?.toString()}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            controller.customeraddressmodel = value!;
            controller.update();
            controller
                .onfetchlocation(LatLng(value.latitude!, value.longitude!));
          },
          buttonStyleData: ButtonStyleData(
            height: 40,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(
              //   color: AppColors.grey,
              // ),
              // color: Colors.white,
            ),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              color: AppColors.primary,
              size: 25,
            ),
            iconSize: 14,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              // color: Colors.white,
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
