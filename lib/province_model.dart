class ProvinceModel {
  String province;
  List<String> city;

  ProvinceModel({this.province, this.city});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    city = json['city'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    data['city'] = this.city;
    return data;
  }
}
