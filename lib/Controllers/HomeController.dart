// ignore_for_file: non_constant_identifier_names

import 'dart:core';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giftappgp/Helper/AppHelper.dart';
import 'package:giftappgp/Models/CategoryModel.dart';
import 'package:giftappgp/Models/cartModel.dart';
import 'package:giftappgp/Models/productModel.dart';
import 'package:giftappgp/Models/userModel.dart';
import 'package:giftappgp/Services/StorageKeys.dart';
import 'package:giftappgp/View/Screens/Cart/shoppingCart.dart';
import 'package:giftappgp/View/Screens/Home/fav.dart';
import 'package:giftappgp/View/Screens/Home/uHome.dart';
import 'package:giftappgp/View/Screens/Product/ListAllCategories.dart';
import 'package:giftappgp/View/Screens/Product/ProductDetails.dart';
import 'package:giftappgp/View/Screens/Profile/Screens/Profile.dart';
import 'package:giftappgp/View/Widgets/noDataAvaliable.dart';
import 'package:http/http.dart' as http;
import 'package:search_page/search_page.dart';

class Homecontroller extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser?.uid;
  int productcartquntity = 1;
  Widget MainContainerBody = Uhome();
  int MainContainerBodyIndex = 0;
  int proudctsView = 1;
  int? randomcat1;
  int? randomcat2;
  int ProudactDestailsOpinionView = 1;
  List<ProudactsModel> ListAllProudacts = [];
  List<CatrgoryModel> categoryList = [];
  List<ProudactsModel> allproducts = [];
  List<ProudactsModel> latestProducts = [];
  List<ProudactsModel> popularProducts = [];
  @override
  void onInit() {
    fetchCategoreis();
    fetchproducts();
    fetchvendors();
    super.onInit();
  }

  handleBottomNavigatorBar({required int i}) {
    switch (i) {
      case 0:
        if (MainContainerBody != Uhome()) {
          MainContainerBody = Uhome();
          MainContainerBodyIndex = 0;
          update();
        }

        break;
      case 1:
        break;
      case 2:
        if (MainContainerBody != Profile()) {
          MainContainerBody = Profile();
          MainContainerBodyIndex = 2;

          update();
        }

        break;
      case 3:
        if (MainContainerBody != Shoppingcart()) {
          MainContainerBody = Shoppingcart();
          MainContainerBodyIndex = 3;

          update();
        }

        break;
      case 4:
        if (MainContainerBody != ListAllCategories()) {
          MainContainerBody = ListAllCategories();
          MainContainerBodyIndex = 4;

          update();
        }

        break;
      case 5:
        if (MainContainerBody != fav()) {
          MainContainerBody = fav();
          MainContainerBodyIndex = 5;

          update();
        }

        break;
      default:
    }
  }

  fetchproducts() async {
    allproducts.clear();
    await db.collection(Storagekeys.products).get().then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          allproducts.add(ProudactsModel.fromJson(element.data()));
        }
        latestProducts = List.from(allproducts);
        latestProducts.sort(
          (a, b) => b.dateAdded!.compareTo(a.dateAdded!),
        );
        popularProducts = List.from(allproducts);
        update();
      }
    });
  }

  fetchCategoreis() async {
    categoryList.clear();
    await db.collection(Storagekeys.categories).get().then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          categoryList.add(CatrgoryModel.fromJson(element.data()));
        }
        randomcat1 = getrandomIntforcategory();
        randomcat2 = getrandomIntforcategory();

        update();
      }
    });
  }

  List<userModel> vendors = [];
  fetchvendors() async {
    vendors.clear();
    await db
        .collection(Storagekeys.users)
        .where(Storagekeys.roleId, isEqualTo: Storagekeys.vendor)
        .get()
        .then((v) {
      if (v.docs.isNotEmpty) {
        for (var element in v.docs) {
          vendors.add(userModel.fromJson(element.data()));
        }
        update();
      }
    });
  }

  handleHomeProductsView({required int i}) {
    if (proudctsView == i) {
      return;
    } else {
      proudctsView = i;
      update();
    }
  }

  handleProudactDestailsOpinionView({required int i}) {
    if (ProudactDestailsOpinionView != i) {
      ProudactDestailsOpinionView = i;
      update();
    }
  }

  IncreaseDeacreaseQuntity({required bool ispositive}) {
    if (ispositive) {
      productcartquntity++;
      update();
    } else {
      if (productcartquntity == 1) {
        return;
      } else {
        productcartquntity--;
        update();
      }
    }
  }

  Future<userModel?> getvendor({required userid}) async {
    try {
      var snapshpt = await db.collection(Storagekeys.users).doc(userid).get();
      return userModel.fromJson(snapshpt.data()!);
      // return null;
    } catch (e) {
      return null;
    }
  }

  addToCart({required productId, int? quntity}) async {
    cartModel model = cartModel(
        productId: productId,
        quntity: quntity ?? productcartquntity,
        userid: user);
    await db.collection(Storagekeys.cart).add(model.toJson()).then((v) async {
      model.id = v.id;
      await db
          .collection(Storagekeys.cart)
          .doc(model.id)
          .update(model.toJson())
          .then((v) {
        Apphelper.bottomsnackbar(
            msg: 'Cart Updated successfully', title: 'user Cart');
      });
    });
  }

  addTofav({required productId, int? quntity}) async {
    cartModel model = cartModel(
        productId: productId,
        quntity: quntity ?? productcartquntity,
        userid: user);
    await db.collection(Storagekeys.fav).add(model.toJson()).then((v) async {
      model.id = v.id;
      await db
          .collection(Storagekeys.fav)
          .doc(model.id)
          .update(model.toJson())
          .then((v) {
        Apphelper.bottomsnackbar(
            msg: 'favourites Updated successfully', title: 'user fav');
      });
    });
  }

  search({required context}) {
    showSearch(
      context: context,
      delegate: SearchPage<ProudactsModel>(
        items: allproducts,
        searchLabel: 'Search people',
        suggestion: Center(
          child: Text('Filter people by name'),
        ),
        failure: Center(
          child: empty(),
        ),
        filter: (person) => [
          person.name,
          person.description,
        ],
        builder: (person) => InkWell(
          onTap: () {
            Get.to(() => ProductDetails(proudactsModel: person));
          },
          child: ListTile(
            title: Text(person.name.toString()),
            subtitle: Text(person.price.toString() + 'le'.tr),
          ),
        ),
      ),
    );
  }

  getprodByCategory({required catid}) {
    ListAllProudacts =
        List.from(allproducts.where((e) => e.categoryId == catid));
    update();
  }

  int getrandomIntforcategory() {
    Random random = new Random();
    int randomNumber = random.nextInt(categoryList.length);
    return randomNumber;
  }
}
