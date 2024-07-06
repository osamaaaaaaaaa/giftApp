// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AdminController.dart';
import 'package:giftappgp/Models/orderModel.dart';
import 'package:giftappgp/View/Screens/Profile/Screens/GMap.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/customtopAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Aorderdetails extends StatelessWidget {
  orderModel? model;
  Aorderdetails({required this.model});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Admincontroller>(
      builder: (controller) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              customTopAppBar(title: 'orders'.tr),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  print('object');
                  controller.openMap(
                      model!.address!.latitude!, model!.address!.longitude!);
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(model!.address!.latitude!,
                              model!.address!.longitude!),
                          zoom: 14.4746,
                        ),
                        // markers: controller.markers,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,

                        // onTap: controller.onmapTap,
                        onMapCreated: (GoogleMapController c) {
                          // controller.googleMapController = c;
                        },
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      height: 200,
                      width: Get.width,
                    ),
                  ],
                ),
              ),
              _widget(
                  title: 'total'.tr,
                  subtitle: model!.price.toString() + 'le'.tr),
              _widget(
                  title: 'status'.tr,
                  subtitle: controller.status[model!.status!]),
              Text(
                'تفاصيل الطلب',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                  height: 250,
                  child: ListView.builder(
                      itemCount: model?.items?.length,
                      itemBuilder: (c, i) => Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 2)
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller
                                      .getProductById(
                                          model?.items![i]['productId'])!
                                      .name
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('x' +
                                    model!.items![i]['quntity'].toString())
                              ],
                            ),
                          ))),
              if (model?.status != 3 && model?.status != 2)
                Column(
                  children: [
                    model?.status == 0
                        ? button(
                            color: Colors.green,
                            title: 'شحن',
                            fontsize: 15,
                            fontColor: Colors.white,
                            height: 40,
                            function: () {
                              model?.status = 1;
                              controller.editorder(model: model!);
                            },
                            width: Get.width)
                        : button(
                            color: Colors.green,
                            title: 'تسليم',
                            fontsize: 15,
                            fontColor: Colors.white,
                            height: 40,
                            function: () {
                              model?.status = 2;
                              controller.editorder(model: model!);
                            },
                            width: Get.width),
                    button(
                        color: Colors.red,
                        title: 'الغاء'.tr,
                        fontsize: 15,
                        fontColor: Colors.white,
                        height: 40,
                        function: () {
                          model?.status = 3;
                          controller.editorder(model: model!);
                        },
                        width: Get.width)
                  ],
                ),
            ],
          ),
        ),
      ),
    );
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
