// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/Models/userModel.dart';
import 'package:giftappgp/Services/StorageKeys.dart';
import 'package:giftappgp/View/Screens/Admin/aHome.dart';
import 'package:giftappgp/View/Screens/Admin/aordersList.dart';
import 'package:giftappgp/View/Screens/Home/mainContainer.dart';
import 'package:giftappgp/View/Screens/Vendor/vHome.dart';
import 'package:giftappgp/View/Screens/Vendor/vendor.dart';
import 'package:giftappgp/View/Shared/Loading.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class Authcontroller extends GetxController {
  var db = FirebaseFirestore.instance;
  Apphelper _apphelper = Apphelper();
  bool authLoading = false;
  PlatformFile? pickedfile;
  UploadTask? uploadTask;

  Future selectimage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) {
      return;
    }
    pickedfile = result.files.first;
    update();
    _uploadtofirestorage();
    update();
  }

  String? url;
  _uploadtofirestorage() async {
    LoadingDialog();
    final path = 'images/${pickedfile!.name}';
    final file = File(pickedfile!.path!);
    final ref = FirebaseStorage.instance.ref(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {Get.back()});
    url = await snapshot.ref.getDownloadURL();

    update();
  }

  signup({required userModel model}) async {
    authLoading = true;
    update();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: model.email.toString().trim(),
        password: model.pass.toString().trim(),
      );
      model.id = credential.user?.uid.toString();
      addUserToDb(model: model);
    } on FirebaseAuthException catch (e) {
      authLoading = false;
      update();
      _apphelper.showDialog(
          context: Get.context,
          type: StylishDialogType.ERROR,
          subtitle: e.code.toString());
    } catch (e) {
      authLoading = false;
      update();
      _apphelper.showDialog(
          context: Get.context,
          type: StylishDialogType.ERROR,
          subtitle: e.toString());
    }
  }

  addUserToDb({required userModel model}) async {
    await db
        .collection(Storagekeys.users)
        .doc(model.id)
        .set(model.toJson())
        .then((v) {
      checkUserRoleId(userId: model.id);
    });
  }

  signin({required email, required pass}) async {
    authLoading = true;
    update();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString().trim(),
        password: pass.toString().trim(),
      );
      checkUserRoleId(userId: credential.user?.uid.toString());
    } on FirebaseAuthException catch (e) {
      authLoading = false;
      update();
      _apphelper.showDialog(
          context: Get.context,
          type: StylishDialogType.ERROR,
          subtitle: e.code.toString());
    } catch (e) {
      authLoading = false;
      update();
      _apphelper.showDialog(
          context: Get.context,
          type: StylishDialogType.ERROR,
          subtitle: e.toString());
    }
  }

  checkUserRoleId({required userId}) async {
    await db.collection(Storagekeys.users).doc(userId).get().then((v) {
      if (v.data() == null) {
        authLoading = false;
        update();
        Apphelper.errorsnackbar('Unknown Error');
      } else if (v.data()!['roleId'] == Storagekeys.user) {
        Get.offAll(() => MainContainer());
      } else if (v.data()!['roleId'] == Storagekeys.vendor) {
        Get.offAll(() => vendor());
      } else if (v.data()!['roleId'] == Storagekeys.delivery) {
        Get.offAll(() => Aorderslist());
      } else if (v.data()!['roleId'] == Storagekeys.admin) {
        Get.offAll(() => aHome());
      }
    });
  }

  restorePassword({required email}) async {
    LoadingDialog();
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email.toString().trim())
        .then((v) {
      update();
      Get.back();
      Get.back();

      Apphelper().showDialog(
          context: Get.context,
          type: StylishDialogType.SUCCESS,
          title: 'Email sent'.tr,
          subtitle: 'we have sent email for u to reset password'.tr);
    });
  }
}
