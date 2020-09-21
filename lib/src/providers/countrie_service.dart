import 'package:dio/dio.dart';
import 'package:search_delegate/src/models/country_model.dart';

class CountryService {
  final Dio dio = new Dio();
  final String _url = 'https://restcountries.eu/rest/v2/name';
  Future<List<CountryModel>> getCountry(String name) async {
    try {
      final resp = await this.dio.get('$_url/$name');
      // print(resp.data);
      final List<dynamic> country = resp.data;
      return country.map((e) => CountryModel.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return e;
    }
  }
}
