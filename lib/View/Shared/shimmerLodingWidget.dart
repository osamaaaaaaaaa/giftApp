import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class shimmerLodingWidget extends StatelessWidget {
  double? h;
  shimmerLodingWidget({this.h});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListTile(
          title: Container(
            height: h ?? 100,
            width: Get.width,
            color: Colors.white,
          ),
        ));
  }
}
