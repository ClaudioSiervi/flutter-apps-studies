import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Contador de pessoas",
    home: Stack(
      children: <Widget>[
        Image.asset(
          "images/restaurant.jpg",
          fit: BoxFit.cover,
          height: 1000.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pessoas: 0",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "+1",
                      style: TextStyle(color: Colors.white, fontSize: 40.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "-1",
                      style: TextStyle(color: Colors.white, fontSize: 40.0),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "Pode entrar!",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w100),
            ),
          ],
        )
      ],
    ),
  ));
}
