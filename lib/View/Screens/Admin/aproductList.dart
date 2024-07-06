import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AdminController.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/View/Screens/Admin/aproductMangment.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/ImageNetwork.dart';
import 'package:giftappgp/View/Shared/customtopAppBar.dart';
import 'package:giftappgp/utils/AppImages.dart';

class Aproductlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Admincontroller>(
        init: Admincontroller(),
        builder: (contrller) => Scaffold(
              body: Column(
                children: [
                  customTopAppBar(title: 'productsmangment'.tr),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (v) {
                        contrller.productSearc(v);
                      },
                      decoration: InputDecoration(
                          hintText: 'Search'.tr,
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: contrller.proudactsList.length,
                          itemBuilder: (context, i) => Container(
                                margin: EdgeInsets.all(2),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 2)
                                    ]),
                                child: Column(
                                  children: [
                                    Row(
                                      //   crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        contrller.proudactsList[i].thumb == null
                                            ? Image.asset(
                                                AppImages.noimage,
                                                height: 100,
                                                width: 100,
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: ImageNetwork(
                                                    src: contrller
                                                        .proudactsList[i].thumb
                                                        .toString(),
                                                    width: 100,
                                                    height: 100),
                                              ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: Get.width - 160),
                                              child: Text(
                                                contrller.proudactsList[i].name
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Container(
                                              //color: Colors.amber,
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(
                                                  //   maxHeight: 60,
                                                  maxWidth: Get.width - 160),
                                              child: Text(
                                                contrller.proudactsList[i]
                                                    .description
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            Text(
                                              contrller.proudactsList[i]
                                                          .status ==
                                                      true
                                                  ? 'published'.tr
                                                  : 'unpublished',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: contrller
                                                              .proudactsList[i]
                                                              .status ==
                                                          true
                                                      ? Colors.green
                                                      : Colors.red,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        button(
                                            color: Colors.green,
                                            title: 'edit'.tr,
                                            fontsize: 15,
                                            fontColor: Colors.white,
                                            height: 35,
                                            icon: Icons.edit,
                                            function: () {
                                              contrller.imagesUrl = contrller
                                                  .proudactsList[i]
                                                  .additional_images!;
                                              try {
                                                contrller.catrgoryValue =
                                                    contrller.categories
                                                        .where((e) =>
                                                            e.categoryId ==
                                                            contrller
                                                                .proudactsList[
                                                                    i]
                                                                .categoryId)
                                                        .first;
                                              } catch (e) {}
                                              contrller.publish = contrller
                                                  .proudactsList[i].status!;
                                              Get.to(() => aProductmangment(
                                                    proudactsModel: contrller
                                                        .proudactsList[i],
                                                  ));
                                            },
                                            width: Get.width / 2.5),
                                        button(
                                            color: Colors.red,
                                            title: 'delete'.tr,
                                            icon: Icons.delete,
                                            fontsize: 15,
                                            fontColor: Colors.white,
                                            height: 35,
                                            function: () {
                                              Apphelper().showAreSureMoreDialg(
                                                  title: null,
                                                  ontap: () {
                                                    contrller.deleteProudct(
                                                        model: contrller
                                                            .proudactsList[i]);
                                                    Get.back();
                                                  });
                                            },
                                            width: Get.width / 2.5)
                                      ],
                                    )
                                  ],
                                ),
                              )))
                ],
              ),
            ));
  }
}
