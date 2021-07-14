import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Contador de pessoas",
      home: Column(
        children: [
          Text("Pessoas: 0"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(40.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text("+1"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text("-1"),
                ),
              )
            ],
          )
        ],
      )));
}
