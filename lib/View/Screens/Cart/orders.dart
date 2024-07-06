// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:giftappgp/Controllers/cartController.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/Models/orderModel.dart';
import 'package:giftappgp/View/Shared/Loading.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:giftappgp/utils/AppIcons.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Cartcontroller>(
        init: Cartcontroller(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: controller.getmyordersLoading
                  ? Loading()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          HomeAppBar(
                            home: false,
                          ),
                          controller.orederList.isEmpty
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.3,
                                    ),
                                    SvgPicture.asset(Appicons.orders,
                                        color: AppColors.grey,
                                        width: 50,
                                        semanticsLabel: 'Acme Logo'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        'empty'.tr,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: Get.height - 170,
                                  child: ListView.builder(
                                      itemCount: controller.orederList.length,
                                      itemBuilder: (context, index) => InkWell(
                                            child: _proudact(
                                                index: index,
                                                model: controller
                                                    .orederList[index],
                                                controller: controller),
                                          ))),
                        ],
                      ),
                    ),
            ));
  }
}

Widget _proudact(
    {required orderModel model,
    required index,
    required Cartcontroller controller}) {
  return Container(
    padding: EdgeInsets.all(5),
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(10)),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#${model.id?[0]}${model.id?[1]}${model.id?[2]}${model.id?[2]}${model.id?[3]}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          Apphelper.dateHelper(model.createdAt.toString()),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            'total'.tr,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                          ),
                          Text(
                            model.price.toString() + 'le'.tr,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            controller.status[model.status!],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    ]),
  );
}
