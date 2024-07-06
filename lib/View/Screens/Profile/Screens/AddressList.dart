// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/ProfileController.dart';
import 'package:giftappgp/Models/addressModel.dart';
import 'package:giftappgp/View/Screens/Profile/Screens/GMap.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/Loading.dart';
import 'package:giftappgp/View/Widgets/HomeAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';

class AddressList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) => Scaffold(
              body: controller.adsressLoading
                  ? Loading()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          HomeAppBar(),
                          button(
                              color: AppColors.primary,
                              title: 'add shipping address'.tr,
                              fontsize: 16,
                              fontColor: Colors.white,
                              height: 40,
                              function: () {
                                Get.to(() => GMaps());
                              },
                              width: Get.width),
                          SizedBox(
                            height: Get.height - 150,
                            child: ListView.builder(
                              itemCount: controller.addressList.length,
                              itemBuilder: (context, index) => _widget(
                                  controller: controller,
                                  addressModel: controller.addressList[index]),
                            ),
                          )
                        ],
                      ),
                    ),
            ));
  }
}

Widget _widget(
        {required ProfileController controller,
        required addressModel addressModel}) =>
    Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addressModel.mobile.toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                child: Text(
                  addressModel.city.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
              Container(
                constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                child: Text(
                  addressModel.street.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  controller.deletaddress(addressModel.id);
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
