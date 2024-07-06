// ignore_for_file: prefer_collection_literals

class addressModel {
  String? id;
  String? userId;

  String? mobile;
  String? street;
  String? city;
  double? latitude;
  double? longitude;

  addressModel(
      {this.id,
      this.userId,
      this.mobile,
      this.street,
      this.city,
      this.latitude,
      this.longitude});

  addressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    mobile = json['mobile'];
    street = json['street'];
    city = json['city'];
    latitude = json['latitude '];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['mobile'] = this.mobile;
    data['street'] = this.street;
    data['city'] = this.city;
    data['latitude '] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
