import 'package:flutter/material.dart';

main(){
  runApp(MaterialApp(
    home: Home(),
  ));
}



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Calculadora de IMC") ,
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.refresh_sharp))
        ],
      ),
    );
  }
}
