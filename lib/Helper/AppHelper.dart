import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:giftappgp/View/Shared/Button.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:intl/intl.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class Apphelper {
  static errorsnackbar(error) {
    return Get.snackbar('Error', error.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  static succssessnackbar(succsses) {
    return Get.snackbar('Succsses', succsses.toString(),
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  static bottomsnackbar({required title, required msg}) {
    Get.showSnackbar(
      GetSnackBar(
        title: title.toString(),
        message: msg.toString(),
        // icon: const Icon(Icons.refresh),
        backgroundColor: Colors.green,

        duration: const Duration(seconds: 3),
      ),
    );
  }

  static dateHelper(date) {
    return DateFormat.yMd()
        .add_jm()
        .format(DateFormat("yyyy-MM-dd hh:mm:ss").parse(date.toString()))
        .toString();
  }

  copyToCilibrate({required String text}) async {
    await Clipboard.setData(ClipboardData(text: text)).then((value) {
      succssessnackbar('Copied To Clipboard');
    });
  }

  showAreSureMoreDialg({required String? title, required Function() ontap}) {
    Get.defaultDialog(
        content: Container(),
        title: title ?? 'Are u Sure ?',
        actions: [
          button(
              color: Colors.green,
              title: 'YES',
              fontsize: 15,
              fontColor: Colors.white,
              height: 40,
              function: ontap,
              width: Get.width / 2),
          button(
              color: Colors.red,
              title: 'NO',
              fontsize: 15,
              fontColor: Colors.white,
              height: 40,
              function: () {
                Get.back();
              },
              width: Get.width / 2)
        ]);
  }

  int getLang() {
    if (Get.locale.toString() == 'en') {
      return 1;
    } else {
      return 2;
    }
  }

  showDialog(
      {required context,
      required StylishDialogType type,
      required subtitle,
      String? title}) {
    StylishDialog(
      context: context,
      alertType: type,
      dismissOnTouchOutside: true,
      title: Text(title ?? ''),
      content: Text(
        '$subtitle',
        textAlign: TextAlign.center,
      ),
    ).show();
  }
}
