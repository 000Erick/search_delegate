import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:search_delegate/src/models/country_model.dart';
import 'package:search_delegate/src/providers/countrie_service.dart';

class CountrySearchDelegate extends SearchDelegate<CountryModel> {
  final countryService = new CountryService();

  @override
  final String searchFieldLabel;
  List<CountryModel> historial;
  CountrySearchDelegate(this.searchFieldLabel, this.historial);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            this.query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          this.close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (this.query.trim().length == 0) {
      return Text('Sin informacion');
    }
    return FutureBuilder(
      future: countryService.getCountry(this.query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return ListTile(
              title: Text('Error en el servicio'),
              subtitle: Text('${snapshot.error}'));
        }
        if (snapshot.hasData) {
          final data = snapshot.data;
          return showCountry(data);
        } else {
          return Center(child: CircularProgressIndicator(strokeWidth: 3));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return showCountry(historial);
  }

  Widget showCountry(List<CountryModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: (data[index].flag != null)
              ? SvgPicture.network(
                  data[index].flag,
                  width: 50,
                )
              : Text(''),
          title: Text(data[index].name),
          subtitle: Text(data[index].capital),
          trailing: Text(data[index].alpha3Code),
          onTap: () {
            this.close(context, data[index]);
          },
        );
      },
    );
  }
}
