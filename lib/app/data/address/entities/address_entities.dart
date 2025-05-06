class AddressEntities {
  final int? id;
  final int? userId;
  final String? name;
  final String? phone;
  final String? address;
  final String? city;
  final String? province;
  final int? cityId;
  final int? provinceId;

  AddressEntities({
    this.id,
    this.userId,
    this.name,
    this.phone,
    this.address,
    this.city,
    this.province,
    this.cityId,
    this.provinceId,
  });

  factory AddressEntities.fromJson(Map<String, dynamic> json) => AddressEntities(
        id: json['id'],
        userId: json['user_id'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        city: json['city'],
        province: json['province'],
        cityId: json['city_id'],
        provinceId: json['province_id'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "address": address,
        "city": city,
        "province": province,
        "city_id": cityId,
        "province_id": provinceId,
      };
}
