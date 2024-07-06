// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Controllers/HomeController.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/Models/addressModel.dart';
import 'package:giftappgp/Models/cartModel.dart';
import 'package:giftappgp/Models/orderModel.dart';
import 'package:giftappgp/Models/productModel.dart';
import 'package:giftappgp/Services/StorageKeys.dart';
import 'package:giftappgp/View/Screens/Home/mainContainer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Cartcontroller extends GetxController {
  var db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser?.uid;
  List<cartModel> cartList = [];
  List<cartModel> favList = [];

  addressModel customeraddressmodel = addressModel();
  Set<Marker> markers = <Marker>{}.obs;
  List status = ['pending', 'in delivery', 'delivered', 'canceld'];
  @override
  void onInit() {
    fetchCartList();
    fetchproducts();
    fetchPastorders();
    fetchAddress();
    fetchfavList();
    super.onInit();
  }

  bool cartLoding = false;
  fetchCartList() async {
    cartList.clear();
    cartLoding = true;
    await db
        .collection(Storagekeys.cart)
        .where(Storagekeys.userid, isEqualTo: user)
        .get()
        .then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          cartList.add(cartModel.fromJson(element.data()));
        }
      }
      cartLoding = false;

      update();
    });
  }

  bool favLoding = false;
  fetchfavList() async {
    favList.clear();
    favLoding = true;
    await db
        .collection(Storagekeys.fav)
        .where(Storagekeys.userid, isEqualTo: user)
        .get()
        .then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          favList.add(cartModel.fromJson(element.data()));
        }
      }
      favLoding = false;

      update();
    });
    update();
  }

  removeFromCart(id) async {
    cartList.clear();
    await db.collection(Storagekeys.cart).doc(id).delete();
    fetchCartList();
    update();
  }

  removeFromfav(id) async {
    await db.collection(Storagekeys.fav).doc(id).delete();
    fetchfavList();
    update();
  }

  List<ProudactsModel> allproducts = [];

  fetchproducts() async {
    allproducts.clear();
    await db.collection(Storagekeys.products).get().then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          allproducts.add(ProudactsModel.fromJson(element.data()));
        }

        update();
      }
    });
  }

  List<orderModel> orederList = [];
  bool getmyordersLoading = false;
  fetchPastorders() async {
    orederList.clear();
    getmyordersLoading = true;
    await db
        .collection(Storagekeys.orders)
        .where(Storagekeys.userid, isEqualTo: user)
        .get()
        .then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          orederList.add(orderModel.fromJson(element.data()));
        }
      }
      getmyordersLoading = false;
      update();
    });
  }

  ProudactsModel? getProductById({required id}) {
    var prod = allproducts.where((e) => e.productId == id).firstOrNull;
    return prod;
  }

  double totalCartPrice() {
    double price = 0;
    for (var e in cartList) {
      var prod = getProductById(id: e.productId);
      if (prod != null) {
        price += ((prod.price)! * (e.quntity!));
      }
    }
    return price;
  }

  List<addressModel> addressList = [];

  fetchAddress() async {
    addressList.clear();

    await db
        .collection(Storagekeys.address)
        .where('userId', isEqualTo: user)
        .get()
        .then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          addressList.add(addressModel.fromJson(element.data()));
        }
        customeraddressmodel = addressList[0];

        update();
        if (customeraddressmodel.latitude != null) {
          onfetchlocation(LatLng(
              customeraddressmodel.latitude!, customeraddressmodel.longitude!));
        }
      }
      update();
    });
  }

  GoogleMapController? googleMapController;
  CameraPosition klocation = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  onfetchlocation(LatLng latLng) async {
    String cityName = '';
    klocation = CameraPosition(target: latLng, zoom: 16);
    await googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 16)));
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
        snippet: '',
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

  addNewOrder({required orderModel model}) async {
    var _homecrt = Get.put(Homecontroller());
    await db.collection(Storagekeys.orders).add(model.toJson()).then((v) async {
      model.id = v.id;
      await db
          .collection(Storagekeys.orders)
          .doc(v.id)
          .update(model.toJson())
          .then((v) {
        Apphelper.bottomsnackbar(
            title: 'Sucsses', msg: 'Order requests Sucssesfully');
        emptyCartList();
        _homecrt.handleBottomNavigatorBar(i: 0);

        Get.to(() => MainContainer());
      });
    });
  }

  emptyCartList() async {
    for (var e in cartList) {
      await db.collection(Storagekeys.cart).doc(e.id).delete();
    }
  }

  // Map<String, dynamic>? paymentIntent;
  // Future<void> makePayment(context,
  //     {required int amount, required int planId}) async {
  //   try {
  //     paymentIntent = await createPaymentIntent('$amount', 'USD');

  //     //STEP 2: Initialize Payment Sheet
  //     await Stripe.instance
  //         .initPaymentSheet(
  //             paymentSheetParameters: SetupPaymentSheetParameters(
  //                 customerId: 'user',
  //                 paymentIntentClientSecret: paymentIntent![
  //                     'client_secret'], //Gotten from payment intent
  //                 // style: ThemeMode.dark,

  //                 merchantDisplayName: 'GiftApp'))
  //         .then((value) {});

  //     //STEP 3: Display Payment sheet
  //     displayPaymentSheet(context, planId);
  //   } catch (err) {
  //     throw Exception(err);
  //   }
  // }

  // displayPaymentSheet(context, planId) async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet().then((value) {
  //       showDialog(
  //           context: context,
  //           builder: (_) => AlertDialog(
  //                 content: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Icon(
  //                       Icons.check_circle,
  //                       color: Colors.green,
  //                       size: 100.0,
  //                     ),
  //                     SizedBox(height: 10.0),
  //                     Text("Payment Successful!"),
  //                   ],
  //                 ),
  //               ));

  //       paymentIntent = null;
  //     }).onError((error, stackTrace) {
  //       throw Exception(error);
  //     });
  //   } on StripeException catch (e) {
  //     print('Error is:---> $e');
  //     AlertDialog(
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Row(
  //             children: const [
  //               Icon(
  //                 Icons.cancel,
  //                 color: Colors.red,
  //               ),
  //               Text("Payment Failed"),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
  //   } catch (e) {
  //     print('$e');
  //   }
  // }

  // createPaymentIntent(String amount, String currency) async {
  //   try {
  //     //Request body
  //     Map<String, dynamic> body = {
  //       'amount': amount,
  //       'currency': currency,
  //     };

  //     //Make post request to Stripe
  //     var response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       headers: {
  //         'Authorization': 'Bearer ${Storagekeys.strpi_sk}',
  //         'Content-Type': 'application/x-www-form-urlencoded'
  //       },
  //       body: body,
  //     );
  //     return json.decode(response.body);
  //   } catch (err) {
  //     throw Exception(err.toString());
  //   }
  // }
}
