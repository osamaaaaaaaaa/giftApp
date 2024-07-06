// ignore_for_file: prefer_collection_literals

import 'package:giftappgp/Models/addressModel.dart';

class orderModel {
  String? id;
  String? userid;
  String? createdAt;
  int? status;
  List? items;
  addressModel? address;
  double? price;

  orderModel(
      {this.id,
      this.userid,
      this.createdAt,
      this.status,
      this.items,
      this.address,
      this.price});

  orderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    createdAt = json['createdAt'];
    status = json['status'];
    items = json['items'];
    address = addressModel.fromJson(json['address']);
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['createdAt'] = this.createdAt;
    data['status'] = this.status;
    data['items'] = this.items;
    data['address'] = this.address?.toJson();
    data['price'] = this.price;
    return data;
  }
}
