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
    createProducts(); // every App start create a product with random value
    super.initState();
  }

  Random randomNumber = new Random(); // Random number generation
  int randomValue(int min, int max) {
    return min + randomNumber.nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {

    // Chart
    var series = [
      new charts.Series<Product, String>(
          id: 'Product',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (Product product, _) => product.name,
          measureFn: (Product product, _) => product.price,
          data: products)
    ];
    var chart = new charts.BarChart(
      series,
      animate: false,
      primaryMeasureAxis: new charts.NumericAxisSpec( 
        tickProviderSpec: new charts.StaticNumericTickProviderSpec( // Static: always show y-axis labels up to 100  
          <charts.TickSpec<num>>[
            charts.TickSpec<num>(0),
            charts.TickSpec<num>(10),
            charts.TickSpec<num>(20),
            charts.TickSpec<num>(30),
            charts.TickSpec<num>(40),
            charts.TickSpec<num>(50),
            charts.TickSpec<num>(60),
            charts.TickSpec<num>(70),
            charts.TickSpec<num>(80),
            charts.TickSpec<num>(90),
            charts.TickSpec<num>(100),
          ],
        ),
      ),
    );

    return SafeArea( // rendering
        child: Scaffold(
            appBar: AppBar(title: Text(widget.title)),
            body: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, top: 20.0, right: 20.0, bottom: 100.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Gesamtverkäufe"),
                      Expanded(child: chart)
                    ]))));
  }
}
