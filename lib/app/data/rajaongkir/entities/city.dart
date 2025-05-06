
class City {
  final String cityId;
  final String cityName;
  final String type;
  final String postalCode;

  City({
    required this.cityId,
    required this.cityName,
    required this.type,
    required this.postalCode,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityId: json['city_id'],
        cityName: json['city_name'],
        type: json['type'],
        postalCode: json['postal_code'],
      );
}