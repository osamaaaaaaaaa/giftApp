// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/View/Widgets/bottomAppBar.dart';

class MainContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Homecontroller>(
        init: Homecontroller(),
        builder: (controller) => Scaffold(
              bottomNavigationBar: BottomApp_Bar(
                back: false,
              ),
              body: controller.MainContainerBody,
            ));
  }
}
