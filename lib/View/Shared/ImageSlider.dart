// ignore_for_file: must_be_immutable, sort_child_properties_last, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:giftappgp/View/Shared/ImageNetwork.dart';

class ImageSlider extends StatelessWidget {
  List images = [];
  double? height;
  ImageSlider({required this.images, required this.height});
  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      /// Width of the [ImageSlideshow].
      width: double.infinity,

      /// Height of the [ImageSlideshow].
      height: height ?? Get.height * 0.5,

      /// The page to show when first creating the [ImageSlideshow].
      initialPage: 0,

      /// The color to paint the indicator.
      indicatorColor: Colors.black,

      /// The color to paint behind th indicator.
      indicatorBackgroundColor: Colors.white,

      /// The widgets to display in the [ImageSlideshow].
      /// Add the sample image file into the images folder
      children: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageNetwork(
                  width: Get.width,
                  height: height,
                  src: images[images.indexOf(i)].toString()),
            );
          },
        );
      }).toList(),

      /// Called whenever the page in the center of the viewport changes.
      onPageChanged: (value) {},

      /// Auto scroll interval.
      /// Do not auto scroll with null or 0.
      autoPlayInterval: 3000,

      /// Loops back to first slide.
      isLoop: true,
    );
  }
}
