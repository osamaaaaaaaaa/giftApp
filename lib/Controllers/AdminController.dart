import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Models/CategoryModel.dart';
import 'package:giftappgp/Models/orderModel.dart';
import 'package:giftappgp/Models/productModel.dart';
import 'package:giftappgp/Models/userModel.dart';
import 'package:giftappgp/Services/StorageKeys.dart';
import 'package:giftappgp/View/Shared/Loading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class Admincontroller extends GetxController {
  var db = FirebaseFirestore.instance;
  bool publish = true;
  CatrgoryModel catrgoryValue = CatrgoryModel();
  List status = ['pending', 'in delivery', 'delivered', 'canceld'];
  List acsses = [
    Storagekeys.admin,
    Storagekeys.vendor,
    Storagekeys.delivery,
    Storagekeys.user,
  ];

  @override
  void onInit() {
    fetchProducts();
    fetchCategoreis();
    fetchOrders();
    fetchusers();
    super.onInit();
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      // throw 'Could not open the map.';
    }
  }

  List<ProudactsModel> proudactsList = [];
  List<ProudactsModel> storgeproudactsList = [];

  fetchProducts() async {
    proudactsList.clear();
    await db
        .collection(Storagekeys.products)
        .orderBy('date_added', descending: true)
        .get()
        .then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          storgeproudactsList.add(ProudactsModel.fromJson(element.data()));
        }
        proudactsList = List.from(storgeproudactsList);
        update();
      }
    });
  }

  productSearc(v) {
    if (v.toString().isEmpty) {
      proudactsList = List.from(storgeproudactsList);
      update();
    } else {
      proudactsList = List.from(storgeproudactsList.where((e) => e.name!
          .toString()
          .toLowerCase()
          .contains(v.toString().toLowerCase())));
      update();
    }
  }

  editProudct({required ProudactsModel model}) async {
    await db
        .collection(Storagekeys.products)
        .doc(model.productId)
        .update(model.toJson())
        .then((v) {
      Get.back();
      fetchProducts();
    });
  }

  deleteProudct({required ProudactsModel model}) async {
    await db
        .collection(Storagekeys.products)
        .doc(model.productId)
        .delete()
        .then((v) {
      fetchProducts();
    });
  }

  editorder({required orderModel model}) async {
    await db
        .collection(Storagekeys.orders)
        .doc(model.id)
        .update(model.toJson());
    update();
    Get.back();
    fetchOrders();
  }

  deletuser(id) async {
    await db.collection(Storagekeys.users).doc(id).delete();
    fetchusers();
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
    Get.back();
    fetchCategoreis();
  }

  editCategory({required CatrgoryModel model}) async {
    await db
        .collection(Storagekeys.categories)
        .doc(model.categoryId)
        .update(model.toJson())
        .then((v) async {});
    Get.back();
    fetchCategoreis();
  }

  deletCat(id) async {
    await db.collection(Storagekeys.categories).doc(id).delete();
    fetchCategoreis();
  }

  List<orderModel> ordersList = [];
  List<orderModel> presentordersList = [];

  fetchOrders() async {
    ordersList.clear();
    await db.collection(Storagekeys.orders).get().then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          ordersList.add(orderModel.fromJson(element.data()));
        }
        presentordersList = List.from(ordersList);
      }
      update();
    });
  }

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

  String? imageurl;
  _uploadtofirestorage() async {
    LoadingDialog();
    final path = 'images/${pickedfile!.name}';
    final file = File(pickedfile!.path!);
    final ref = FirebaseStorage.instance.ref(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {Get.back()});
    imageurl = await snapshot.ref.getDownloadURL();

    update();
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

  List<userModel> usersList = [];
  List<userModel> presentusdserlist = [];

  fetchusers() async {
    usersList.clear();
    await db.collection(Storagekeys.users).get().then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          usersList.add(userModel.fromJson(element.data()));
        }
        presentusdserlist = List.from(usersList);
        update();
      }
    });
  }

  edituser(userModel model) async {
    await db.collection(Storagekeys.users).doc(model.id).update(model.toJson());

    fetchusers();
  }

  usersearch(v) {
    if (v.toString().isEmpty) {
      presentusdserlist = List.from(usersList);
      update();
    } else {
      presentusdserlist =
          List.from(usersList.where((e) => e.email!.contains(v)));
      update();
    }
  }

  orderssearch(v) {
    if (v.toString().isEmpty) {
      presentordersList = List.from(ordersList);
      update();
    } else {
      presentordersList = List.from(ordersList.where((e) =>
          e.id.toString().toLowerCase().contains(v.toString().toLowerCase())));
      update();
    }
  }

  GoogleMapController? googleMapController;
  CameraPosition klocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  ProudactsModel? getProductById(id) {
    ProudactsModel? model;
    model = proudactsList.where((e) => e.productId == id).firstOrNull;
    return model;
  }
}
