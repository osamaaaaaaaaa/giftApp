// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:giftappgp/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget Loading({double? size, Color? color}) => Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
      color: color ?? AppColors.primary,
      size: size ?? 100,
    ));
Widget Loadingcart({double? size}) => Center(
        child: Container(
      padding: EdgeInsets.all(10),
      child: LoadingAnimationWidget.twoRotatingArc(
        color: AppColors.primary,
        size: size ?? 100,
      ),
    ));

LoadingDialog({Color? color}) => Get.defaultDialog(
    title: '',
    backgroundColor: Colors.transparent,
    content: Loading(color: color));
