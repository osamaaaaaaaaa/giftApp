// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Models/CategoryModel.dart';
import 'package:giftappgp/Models/productModel.dart';
import 'package:giftappgp/Services/StorageKeys.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:giftappgp/View/Shared/Loading.dart';
import 'package:image_picker/image_picker.dart';

class Vendorcontroller extends GetxController {
  var db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser?.uid;
  CatrgoryModel catrgoryValue = CatrgoryModel();
  bool publish = true;
  @override
  void onInit() {
    fetchCategoreis();
    fetchproducts();
    super.onInit();
  }

  List<CatrgoryModel> categories = [];
  fetchCategoreis() async {
    categories.clear();
    await db.collection(Storagekeys.categories).get().then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          categories.add(CatrgoryModel.fromJson(element.data()));
        }
        catrgoryValue = categories[0];

        update();
      }
    });
  }

  List<ProudactsModel> proudactsList = [];
  fetchproducts() async {
    proudactsList.clear();
    await db
        .collection(Storagekeys.products)
        .where('vendorId', isEqualTo: user)
        .get()
        .then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          proudactsList.add(ProudactsModel.fromJson(element.data()));
        }
        update();
      }
    });
  }

  addnewProudact({required ProudactsModel model}) async {
    LoadingDialog();
    await db
        .collection(Storagekeys.products)
        .add(model.toJson())
        .then((v) async {
      model.productId = v.id;
      await db
          .collection(Storagekeys.products)
          .doc(v.id)
          .update(model.toJson());
      Get.back();
      Get.back();
    });
    fetchproducts();
  }

  editProudct({required ProudactsModel model}) async {
    await db
        .collection(Storagekeys.products)
        .doc(model.productId)
        .update(model.toJson())
        .then((v) {
      Get.back();
      fetchproducts();
    });
  }

  deleteProudct({required ProudactsModel model}) async {
    await db
        .collection(Storagekeys.products)
        .doc(model.productId)
        .delete()
        .then((v) {
      fetchproducts();
    });
  }

  addnewCategory({required CatrgoryModel model}) async {
    await db
        .collection(Storagekeys.categories)
        .add(model.toJson())
        .then((v) async {
      model.categoryId = v.id;
      await db
          .collection(Storagekeys.categories)
          .doc(v.id)
          .update(model.toJson());
    });
    fetchCategoreis();
  }

  List<dynamic> imagesUrl = [];
  Future<List<XFile>> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      uploadImages(images);
    }
    return images ?? [];
  }

  Future<void> uploadImages(List<XFile> images) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    int i = 0;
    for (XFile image in images) {
      File file = File(image.path);
      try {
        await storage
            .ref('uploads/${image.name}')
            .putFile(file)
            .then((v) async {
          imagesUrl.add(await v.ref.getDownloadURL());
          i++;
          update();
        });
      } on FirebaseException catch (e) {
        // Handle errors
      }
    }
  }
}
