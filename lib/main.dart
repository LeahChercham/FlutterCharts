// import 'package:flutter/cupertino.dart'; // macht irgendwelche bugs beim starten
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Säulendiagramm',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MainPage(title: 'Säulendiagramm'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  ChartScreen createState() => new ChartScreen();
}

class Product {
  String name;
  int price;

  Product(this.name, this.price);

  @override
  String toString() {
    return '{ ${this.name}, ${this.price}}';
  }
}

class ChartScreen extends State<MainPage> {

  String letters = "ABCDEFGH";
  List<Product> products = [];
  bool animate = false;

  void createProducts() {
    letters.split("").forEach(
        (letter) => {products.add(Product(letter, randomValue(0, 100)))});
  }

  late List<charts.Series> seriesList;

  @override
  void initState() {
    createProducts();
    super.initState();
  }


  Random _randomNumber = new Random();
  int randomValue(int min, int max) {
    return min + _randomNumber.nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    var series = [
      new charts.Series<Product, String>(
        id: 'Product',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Product product, _) => product.name,
        measureFn: (Product product, _) => product.price,
        data: products,
      )
    ];
    var chart = new charts.BarChart(series, animate:false);

    return SafeArea(child: Scaffold(body: chart));
  }
}
