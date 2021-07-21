import 'dart:ffi';

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
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolarExchange = 0.0;
  double euroExchange = 0.0;

  void _realChanged(String text) {
    double real = double.parse(text);
    dolarController.text = (real / this.dolarExchange).toStringAsFixed(2);
    euroController.text = (real / this.euroExchange).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolarExchange).toStringAsFixed(2);
    euroController.text =
        (dolar * this.dolarExchange / euroExchange).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    realController.text = (euro * this.euroExchange).toStringAsFixed(2);
    dolarController.text =
        (euro * this.euroExchange / this.dolarExchange).toStringAsFixed(2);
  }

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
                dolarExchange =
                    snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euroExchange =
                    snapshot.data!["results"]["currencies"]["EUR"]["buy"];

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
                      buildTextField(
                          "Reais", "R\$", realController, _realChanged),
                      Divider(),
                      buildTextField(
                          "Dolares", "US\$", dolarController, _dolarChanged),
                      Divider(),
                      buildTextField(
                          "Euros", "EU", euroController, _euroChanged),
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

Widget buildTextField(String labelText, String prefixText,
    TextEditingController c, Function(String) f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefixText),
    style: TextStyle(
      color: Colors.amber,
      fontSize: 25.0,
    ),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}
