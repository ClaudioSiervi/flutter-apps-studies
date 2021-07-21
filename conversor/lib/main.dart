import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

var request = Uri.parse('https://api.hgbrasil.com/finance/');

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        highlightColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.amber,
            )),
            hintStyle: TextStyle(
              color: Colors.amber,
            ))),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  if (response.statusCode == 200) {
    return convert.jsonDecode(response.body);
  } else {
    print('Request failed with status: ${response.statusCode}.');
    throw '';
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double? dolar;
  double? euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Text(
                "Carregando dados ...",
                style: TextStyle(color: Colors.amber, fontSize: 25.0),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erro ao carregar dados.",
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                print(dolar.toString());
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150.0,
                        color: Colors.amber,
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Reais",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "R\$"),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Dolares",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "US\$"),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Euros",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "EU"),
                      ),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
