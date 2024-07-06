import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/Models/addressModel.dart';
import 'package:giftappgp/Models/userModel.dart';
import 'package:giftappgp/Services/LocationHandler.dart';
import 'package:giftappgp/Services/StorageKeys.dart';
import 'package:giftappgp/View/Shared/Loading.dart';
import 'package:giftappgp/View/Widgets/custombutton.dart';
import 'package:giftappgp/utils/AppColors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfileController extends GetxController {
  var db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser?.uid;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();
  var confirmNewPassController = TextEditingController();
  var fullnamecontroller = TextEditingController();
  var address1controller = TextEditingController();

  var city = TextEditingController();
  var postalcode = TextEditingController();
  List<addressModel> addressList = [];
  Set<Marker> markers = <Marker>{}.obs;
  userModel? userinfo;
  @override
  void onInit() {
    fetchAddress();
    getuserinfo();
    fetchMyLocatin();
    super.onInit();
  }

  getuserinfo() async {
    await db.collection(Storagekeys.users).doc(user).get().then((v) {
      if (v.data() != null) {
        userinfo = userModel.fromJson(v.data()!);
        url = userinfo?.image;
        update();
        setvalues();
      }
    });
  }

  setvalues() {
    firstNameController.text = userinfo!.name.toString();
    emailController.text = userinfo!.email.toString();

    mobileController.text = userinfo!.mobile.toString();
    update();
  }

  bool adsressLoading = false;
  fetchAddress() async {
    addressList.clear();
    adsressLoading = true;

    await db
        .collection(Storagekeys.address)
        .where('userId', isEqualTo: user)
        .get()
        .then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          addressList.add(addressModel.fromJson(element.data()));
        }
        update();
      }
      adsressLoading = false;
      update();
    });
  }

  addNewAddress({required addressModel model}) async {
    LoadingDialog();
    await db
        .collection(Storagekeys.address)
        .add(model.toJson())
        .then((v) async {
      model.id = v.id;
      await db.collection(Storagekeys.address).doc(v.id).update(model.toJson());
    }).then((v) {
      Get.back();

      Get.back();
      Get.back();

      Apphelper.bottomsnackbar(
          title: 'Address', msg: 'Address added Sucssesfully');
    });
    fetchAddress();
  }

  deletaddress(id) async {
    await db.collection(Storagekeys.address).doc(id).delete();
    fetchAddress();
  }

  LatLng? latLng;
  setAddress(LatLng latLng) async {
    var address = await LocationHandler.getAddressFromLatLng(latLng);
    if (address != null) {
      this.latLng = latLng;
      city.text = address.subAdministrativeArea.toString();
      address1controller.text = address.street.toString();
    }
    update();
  }

  GoogleMapController? googleMapController;
  CameraPosition klocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  fetchMyLocatin() async {
    var x = await LocationHandler.getCurrentPosition();
    if (x != null) {
      klocation =
          CameraPosition(target: LatLng(x.latitude, x.longitude), zoom: 16);
      onfetchlocation(klocation.target);
      setAddress(LatLng(x.latitude, x.longitude));

      await googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(x.latitude, x.longitude), zoom: 16)));
    }
  }

  editUser() async {
    userinfo?.name = firstNameController.text.toString();
    userinfo?.mobile = mobileController.text.toString();
    userinfo?.email = emailController.text.toString();

    await db
        .collection(Storagekeys.users)
        .doc(userinfo?.id)
        .update(userinfo!.toJson());
    getuserinfo();
    Get.back();
  }

  changePassword() async {
    try {
      FirebaseAuth.instance.currentUser?.updatePassword(newPassController.text);
      Get.back();
    } on FirebaseAuthException catch (e) {
      Apphelper.errorsnackbar(e);
    } catch (e) {
      Apphelper.errorsnackbar(e);
    }
  }

  onfetchlocation(LatLng latLng) async {
    String cityName = '';

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        cityName = placemarks.first.name!;
      }
    } catch (err) {
      // alertDialog("تنبيه", err.toString());
    }

    final newMarker = Marker(
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      infoWindow: InfoWindow(
        title: cityName,
        snippet: 'أنقر لحذف العلامة',
        onTap: () {
          // Show InfoWindow content with a delete button
          showModalBottomSheet<void>(
            context: Get.context!,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        'اسم العلامة : $cityName',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 28),
                    CustomBotton(
                        onPressed: () {
                          markers.removeWhere((marker) =>
                              marker.markerId == MarkerId(latLng.toString()));
                          update();
                          Navigator.pop(context);
                        },
                        text: "حذف")
                  ],
                ),
              );
            },
          );
        },
      ),
    );
    markers.clear();
    markers.add(newMarker);

    Future.delayed(const Duration(seconds: 1), () {
      // Get.back();
      googleMapController?.showMarkerInfoWindow(newMarker.markerId);
    });
    update();
  }

  onmapTap(LatLng latLng) async {
    String cityName = '';
    setAddress(latLng);
    var zoomLevel = await googleMapController?.getZoomLevel();
    if (zoomLevel! <= 14) {
      // showToast("يرجى التقريب اكثر على المكان لوضع علامة", Get.context!);
    } else {
      Get.dialog(
          const Center(
              child: CircularProgressIndicator(color: AppColors.primary)),
          barrierDismissible: false);
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          latLng.latitude,
          latLng.longitude,
        );
        if (placemarks.isNotEmpty) {
          cityName = placemarks.first.name!;
        }
      } catch (err) {
        // alertDialog("تنبيه", err.toString());
      }

      final newMarker = Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        infoWindow: InfoWindow(
          title: cityName,
          snippet: 'أنقر لحذف العلامة',
          onTap: () {
            // Show InfoWindow content with a delete button
            showModalBottomSheet<void>(
              context: Get.context!,
              builder: (BuildContext context) {
                return Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          'اسم العلامة : $cityName',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 28),
                      CustomBotton(
                          onPressed: () {
                            markers.removeWhere((marker) =>
                                marker.markerId == MarkerId(latLng.toString()));
                            update();
                            Navigator.pop(context);
                          },
                          text: "حذف")
                    ],
                  ),
                );
              },
            );
          },
        ),
      );
      markers.clear();
      markers.add(newMarker);

      Future.delayed(const Duration(seconds: 1), () {
        Get.back();
        googleMapController?.showMarkerInfoWindow(newMarker.markerId);
      });

      update();
    }
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
}
