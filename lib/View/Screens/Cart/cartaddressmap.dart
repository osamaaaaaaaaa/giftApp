import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:giftappgp/Controllers/cartController.dart';
import 'package:giftappgp/View/Screens/Profile/Screens/GMap.dart';
import 'package:giftappgp/utils/AppColors.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class cartaddressmap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Cartcontroller>(
        init: Cartcontroller(),
        builder: (controller) => Scaffold(
              body: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      myLocationButtonEnabled: true,
                      initialCameraPosition: controller.klocation,
                      markers: controller.markers,
                      // onTap: controller.onmapTap,
                      onMapCreated: (GoogleMapController c) {
                        controller.googleMapController = c;
                        Cartcontroller().fetchAddress();
                      },
                    ),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: () {
                  Get.to(() => GMaps());
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ));
  }
}
