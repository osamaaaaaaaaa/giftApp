// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/AdminController.dart';
import 'package:giftappgp/Controllers/VendorController.dart';
import 'package:giftappgp/Helper/valied_input.dart';
import 'package:giftappgp/Models/CategoryModel.dart';
import 'package:giftappgp/Models/productModel.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/View/Shared/componantes.dart';
import 'package:giftappgp/View/Shared/customtopAppBar.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class aProductmangment extends StatelessWidget {
  ProudactsModel? proudactsModel;
  aProductmangment({this.proudactsModel}) {
    if (proudactsModel != null) {
      prodname.text = proudactsModel!.name.toString();
      prodprice.text = proudactsModel!.price.toString();
      prodquntity.text = proudactsModel!.quantity.toString();
      proddesc.text = proudactsModel!.description.toString();
      prodname.text = proudactsModel!.name.toString();
    }
  }
  var prodname = TextEditingController();
  var prodprice = TextEditingController();
  var prodquntity = TextEditingController();
  var proddesc = TextEditingController();
  // var prodname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formstate = GlobalKey<FormState>();
    return GetBuilder<Admincontroller>(
        init: Admincontroller(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      customTopAppBar(title: 'productsmangment'.tr),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 150,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.pickImages();
                              },
                              child: Container(
                                  margin: EdgeInsets.all(5),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: Colors.grey)),
                                  child: Icon(Icons.add_photo_alternate)),
                            ),
                            SizedBox(
                              height: 150,
                              width: Get.width - 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.imagesUrl.length,
                                itemBuilder: (context, i) => InkWell(
                                  onLongPress: () {
                                    controller.imagesUrl.removeAt(i);
                                    controller.update();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        controller.imagesUrl[i],
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      customTextFieldWidget(
                          controller: prodname,
                          title: 'pn'.tr,
                          enable: true,
                          iconData: null,
                          validator: (v) {
                            return validInput(v.toString(), 1, 250, '');
                          },
                          IsPass: false,
                          height: 50,
                          width: Get.width),
                      customTextFieldWidget(
                          controller: prodprice,
                          title: 'pp'.tr,
                          enable: true,
                          iconData: null,
                          Isnumber: true,
                          validator: (v) {
                            return validInput(v.toString(), 1, 250, '');
                          },
                          IsPass: false,
                          height: 50,
                          width: Get.width),
                      customTextFieldWidget(
                          controller: prodquntity,
                          title: 'pq'.tr,
                          enable: true,
                          iconData: null,
                          IsPass: false,
                          validator: (v) {
                            return validInput(v.toString(), 1, 250, '');
                          },
                          height: 50,
                          width: Get.width),
                      customTextFieldWidget(
                          controller: proddesc,
                          title: 'pd'.tr,
                          enable: true,
                          validator: (v) {
                            return validInput(v.toString(), 1, 250, '');
                          },
                          iconData: null,
                          IsPass: false,
                          height: 120,
                          maxline: 5,
                          width: Get.width),
                      Row(
                        children: [
                          Checkbox(
                              value: controller.publish,
                              onChanged: (v) {
                                controller.publish = v!;
                                controller.update();
                              }),
                          Text('publish'.tr)
                        ],
                      ),
                      if (controller.categories.isNotEmpty)
                        _categories(controller: controller),
                      button(
                          color: AppColors.primary,
                          title: 'save'.tr,
                          fontsize: 15,
                          fontColor: Colors.white,
                          height: 50,
                          function: () {
                            if (formstate.currentState!.validate()) {
                              if (proudactsModel != null) {
                                controller.editProudct(
                                    model: ProudactsModel(
                                        productId: proudactsModel?.productId,
                                        name: prodname.text,
                                        description: proddesc.text,
                                        quantity: int.parse(prodquntity.text),
                                        price: double.parse(prodprice.text),
                                        thumb: controller.imagesUrl.isEmpty
                                            ? null
                                            : controller.imagesUrl[0],
                                        additional_images:
                                            List.from(controller.imagesUrl),
                                        dateModified: DateTime.now().toString(),
                                        dateAdded: proudactsModel?.dateAdded,
                                        categoryId:
                                            controller.catrgoryValue.categoryId,
                                        vendorId: proudactsModel?.vendorId,
                                        status: controller.publish));
                                return;
                              }
                            }
                          },
                          width: Get.width)
                    ],
                  ),
                ),
              ),
            ));
  }
}

Widget _categories({required Admincontroller controller}) => Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      width: Get.width,
      height: 40,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<CatrgoryModel>(
          isExpanded: true, //
          hint: Row(
            children: [
              Icon(
                Icons.list,
                size: 20,
                color: Colors.black,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  controller.catrgoryValue.name.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: controller.categories
              .map((CatrgoryModel item) => DropdownMenuItem<CatrgoryModel>(
                    value: item,
                    child: Center(
                      child: Text(
                        item.name.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold, //
                          color: AppColors.primary,
                        ),
                        //overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ))
              .toList(),
          value: controller.catrgoryValue,
          onChanged: (value) {
            controller.catrgoryValue = value!;
            controller.update();
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: Get.width,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.grey,
              ),
              color: Colors.white,
            ),
            elevation: 3,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down,
            ),
            iconSize: 20,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 400,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              crossAxisMargin: 20,
              mainAxisMargin: 20,
              // showTrackOnHover: true,
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            // padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
