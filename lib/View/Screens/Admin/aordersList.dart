// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AdminController.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/Models/orderModel.dart';
import 'package:giftappgp/View/Screens/Admin/aorderDetails.dart';
import 'package:giftappgp/View/Shared/customtopAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';

class Aorderslist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Admincontroller>(
        init: Admincontroller(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  customTopAppBar(title: 'orders'.tr),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (v) {
                        controller.orderssearch(v);
                      },
                      decoration: InputDecoration(
                          hintText: 'Search By ID'.tr,
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: controller.presentordersList.length,
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {
                                  Get.to(() => Aorderdetails(
                                        model: controller.presentordersList[i],
                                      ));
                                },
                                child: _proudact(
                                    model: controller.presentordersList[i],
                                    index: i,
                                    controller: controller),
                              )))
                ],
              ),
            ));
  }
}

Widget _proudact(
    {required orderModel model,
    required index,
    required Admincontroller controller}) {
  return Container(
    padding: EdgeInsets.all(5),
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5)
        ],
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: Get.width * 0.7 - 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.address!.city.toString() +
                    ',' +
                    model.address!.street.toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
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
        ),
        Container(
          width: Get.width * 0.22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
  );
}
