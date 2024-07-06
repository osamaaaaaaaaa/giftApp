// ignore_for_file: prefer_const_constructors, unused_element, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/utils/AppColors.dart';

class drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
      init: Homecontroller(),
      builder: (controller) => Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  //color: Colors.black,
                  ),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/circle-user_9821720.svg',
                          width: 50,
                          color: Colors.grey,
                          semanticsLabel: 'Acme Logo'),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          //           Get.to(() => EditProfile());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'editprofile'.tr,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _widget(title: 'title', icon: Icons.abc, fun: () {}),
            SizedBox(
              height: 20,
            ),
            if (Get.locale.toString() == 'en')
              button(
                  color: AppColors.primary,
                  title: 'عربي',
                  fontsize: 15,
                  fontColor: Colors.white,
                  height: 40,
                  function: () {
                    //controller.ChangeLang(2);
                  },
                  width: 150),
            if (Get.locale.toString() == 'ar')
              button(
                  color: AppColors.primary,
                  title: 'English',
                  fontsize: 15,
                  fontColor: Colors.white,
                  height: 40,
                  function: () {
                    //  controller.ChangeLang(1);
                  },
                  width: 150),
          ],
        ),
      ),
    );
  }
}

Widget _widget(
        {required title, required IconData icon, required Function() fun}) =>
    Container(
      child: ListTile(
        title: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        onTap: fun,
      ),
    );
