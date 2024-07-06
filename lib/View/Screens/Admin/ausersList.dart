import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AdminController.dart';
import 'package:giftappgp/Models/userModel.dart';
import 'package:giftappgp/Services/StorageKeys.dart';
import 'package:giftappgp/View/Shared/customtopAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';

class ausersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Admincontroller>(
        init: Admincontroller(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  customTopAppBar(title: 'users'.tr),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (v) {
                        controller.usersearch(v);
                      },
                      decoration: InputDecoration(
                          hintText: 'Search Emails'.tr,
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: controller.presentusdserlist.length,
                          itemBuilder: (c, i) => Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 2)
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.presentusdserlist[i].roleId
                                              .toString(),
                                          style: TextStyle(
                                              color: controller
                                                          .presentusdserlist[i]
                                                          .roleId ==
                                                      Storagekeys.admin
                                                  ? Colors.red
                                                  : controller
                                                              .presentusdserlist[
                                                                  i]
                                                              .roleId ==
                                                          Storagekeys.delivery
                                                      ? Colors.green
                                                      : controller
                                                                  .presentusdserlist[
                                                                      i]
                                                                  .roleId ==
                                                              Storagekeys.vendor
                                                          ? AppColors.primary
                                                          : Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(controller
                                            .presentusdserlist[i].name
                                            .toString()),
                                        Text(controller
                                            .presentusdserlist[i].email
                                            .toString()),
                                      ],
                                    ),
                                    _options(
                                        controller: controller,
                                        model: controller.presentusdserlist[i])
                                  ],
                                ),
                              )))
                ],
              ),
            ));
  }
}

Widget _options(
    {required Admincontroller controller, required userModel model}) {
  return PopupMenuButton(
      // add icon, by default "3 dot" icon
      // icon: Icon(Icons.book)
      itemBuilder: (context) {
    return [
      PopupMenuItem<int>(
        value: 0,
        child: Text("Admin".tr),
      ),
      PopupMenuItem<int>(
        value: 1,
        child: Text("vendor".tr),
      ),
      PopupMenuItem<int>(
        value: 2,
        child: Text("Delivery".tr),
      ),
      PopupMenuItem<int>(
        value: 3,
        child: Text("User".tr),
      ),
      PopupMenuItem<int>(
        value: 4,
        textStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        child: Text("delete".tr),
      ),
    ];
  }, onSelected: (value) {
    if (value == 4) {
      controller.deletuser(model.id);
      return;
    }
    model.roleId = controller.acsses[value];
    // print(model.roleId);
    controller.edituser(model);
  });
}
