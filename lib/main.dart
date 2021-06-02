import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/screens/products_page.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ByteKart',
        theme: ThemeData(
          appBarTheme: Theme.of(context).appBarTheme.copyWith(brightness: Brightness.light),
          primaryColor: Color.fromRGBO(11, 20, 35, 1),
          accentColor: Colors.red,
          primarySwatch: Colors.blue,
        ),
        home: ProductsPage(),
      ),
    );
  }
}
