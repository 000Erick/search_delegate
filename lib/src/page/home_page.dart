import 'package:flutter/material.dart';
import 'package:search_delegate/src/models/country_model.dart';
import 'package:search_delegate/src/search/country_search.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CountryModel country;
  List<CountryModel> historial = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (country != null) ? Text('${country.name}') : Text('Sin pais'),
            RaisedButton(
              onPressed: () => callSearch(context),
              child: Text('Selecionar'),
              color: Colors.teal,
              textColor: Colors.white,
              shape: StadiumBorder(),
              elevation: 3.0,
            )
          ],
        ),
      ),
    );
  }

  callSearch(BuildContext context) async {
    country = await showSearch(
        context: context, delegate: CountrySearchDelegate('Buscar', historial));
    historial.add(country);
    setState(() {});
  }
}
