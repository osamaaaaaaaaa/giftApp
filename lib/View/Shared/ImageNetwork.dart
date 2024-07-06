// ignore_for_file: prefer_if_null_operators, prefer_const_constructors, depend_on_referenced_packages, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/View/Shared/shimmerLodingWidget.dart';

Widget ImageNetwork(
        {required String src, double? width, double? height, Color? color}) =>
    CachedNetworkImage(
      imageUrl: src,
      width: width == null ? Get.width : width,
      height: height == null ? 200 : height,
      fit: BoxFit.cover,
      color: color,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          shimmerLodingWidget(h: height),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
