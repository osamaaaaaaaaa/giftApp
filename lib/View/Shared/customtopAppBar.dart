// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/utils/AppColors.dart';

Widget customTopAppBar(
        {required title,
        IconData? icon,
        bool? search,
        Function()? onsearch,
        bool? back,
        Color? backgroundcolor,
        Color? fontcolor}) =>
    Container(
      padding: EdgeInsets.only(top: 25, left: 7, right: 7),
      height: search == true ? 160 : 120,
      width: Get.width,
      decoration: BoxDecoration(
          color: backgroundcolor ?? AppColors.primary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(
                  20))), // margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              back != null
                  ? SizedBox(
                      width: 20,
                    )
                  : InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: fontcolor ?? Colors.white,
                        size: 25,
                      ),
                    ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  title.toString(),
                  style: TextStyle(
                      color: fontcolor ?? Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              icon == null
                  ? SizedBox(
                      width: 20,
                    )
                  : Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 4, 116, 116),
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
            ],
          ),
          if (search == true)
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: onsearch,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.primary,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.white)),
                          // focusedBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(20),
                          //     borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
