import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AdminController.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/View/Screens/Admin/acatMange.dart';
import 'package:giftappgp/View/Shared/ImageNetwork.dart';
import 'package:giftappgp/View/Shared/customtopAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';

class acategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Admincontroller>(
        init: Admincontroller(),
        builder: (controller) => Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: AppColors.primary,
                onPressed: () {
                  Get.to(() => Acatmange());
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              body: Scaffold(
                body: Column(
                  children: [
                    customTopAppBar(title: 'categories'.tr),
                    SizedBox(
                      height: 25,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: controller.categories.length,
                            itemBuilder: (c, i) => InkWell(
                                  onTap: () {
                                    controller.imageurl =
                                        controller.categories[i].image;
                                    Get.to(Acatmange(
                                      catrgoryModel: controller.categories[i],
                                    ));
                                  },
                                  onLongPress: () {
                                    Apphelper().showAreSureMoreDialg(
                                        title: null,
                                        ontap: () {
                                          Get.back();
                                          controller.deletCat(controller
                                              .categories[i].categoryId);
                                        });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        ImageNetwork(
                                            height: 80,
                                            width: 80,
                                            src: controller.categories[i].image
                                                .toString()),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(controller.categories[i].name
                                            .toString())
                                      ],
                                    ),
                                  ),
                                )))
                  ],
                ),
              ),
            ));
  }
}
