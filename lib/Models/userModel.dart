// ignore_for_file: prefer_collection_literals

import 'package:giftappgp/Models/addressModel.dart';

class userModel {
  String? id;
  String? name;
  String? email;
  String? pass;
  String? roleId;
  String? mobile;
  String? vendorname;
  String? image;

  List<addressModel>? addressList;
  String? createdAt;
  String? lastActive;
  String? orderHistory;

  userModel(
      {this.id,
      this.name,
      this.email,
      this.pass,
      this.roleId,
      this.image,
      this.mobile,
      this.addressList,
      this.vendorname,
      this.createdAt,
      this.lastActive,
      this.orderHistory});

  userModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    pass = json['pass'];
    roleId = json['roleId'];
    mobile = json['mobile'];
    image = json['image'];
    vendorname = json['vendorname'];
    if (json['addressList'] != null) {
      addressList = <addressModel>[];
      json['addressList'].forEach((v) {
        addressList?.add(addressModel.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    lastActive = json['lastActive'];
    orderHistory = json['orderHistory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['pass'] = pass;
    data['roleId'] = roleId;
    data['mobile'] = mobile;
    data['image'] = image;
    data['vendorname'] = vendorname;
    if (addressList != null) {
      data['addressList'] = addressList!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['lastActive'] = lastActive;
    data['orderHistory'] = orderHistory;
    return data;
  }
}
