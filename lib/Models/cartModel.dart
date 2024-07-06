class cartModel {
  String? id;
  String? userid;

  String? productId;
  int? quntity;

  cartModel({this.id, this.productId, this.quntity, this.userid});

  cartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    quntity = json['quntity'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['quntity'] = this.quntity;
    data['userid'] = this.userid;
    return data;
  }
}
