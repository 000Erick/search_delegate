import 'dart:convert';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    this.name,
    this.alpha3Code,
    this.capital,
    this.flag,
  });

  String name;
  String alpha3Code;
  String capital;
  String flag;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: json["name"],
        alpha3Code: json["alpha3Code"],
        capital: json["capital"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "alpha3Code": alpha3Code,
        "capital": capital,
        "flag": flag,
      };
}
