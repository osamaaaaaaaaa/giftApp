import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:giftappgp/Controllers/ProfileController.dart';
import 'package:giftappgp/View/Screens/Profile/Screens/addresForm.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMaps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) => Scaffold(
              body: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: controller.klocation,
                    markers: controller.markers,
                    myLocationEnabled: true,
                    onTap: controller.onmapTap,
                    onMapCreated: (GoogleMapController c) {
                      controller.googleMapController = c;
                    },
                  ),
                  Positioned(
                    right: 5,
                    left: 5,
                    bottom: 100,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: button(
                          color: AppColors.primary,
                          title: 'continue'.tr,
                          fontsize: 16,
                          fontColor: Colors.white,
                          height: 40,
                          function: () {
                            Get.to(() => addressForm());
                          },
                          width: Get.width),
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: controller.fetchMyLocatin,
                child: const Icon(
                  Icons.room,
                  color: Colors.white,
                ),
                // label: const Text(
                //   'current Location',
                //   style: TextStyle(color: Colors.white),
                // ),
              ),
            ));
  }
}
