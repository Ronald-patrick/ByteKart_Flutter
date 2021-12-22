import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cartProvider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/login.dart';
import 'package:shop_app/screens/products_page.dart';
import 'package:shop_app/widgets/splash_screen.dart';
import './providers/products_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (_, auth, prevProducts) => Products(auth.token,
              prevProducts == null ? [] : prevProducts.items, auth.userId),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (_, auth, previousOrders) => Orders(auth.token,
              previousOrders == null ? [] : previousOrders.orderList),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'ByteKart',
                theme: ThemeData(
                  appBarTheme: Theme.of(context)
                      .appBarTheme
                      .copyWith(brightness: Brightness.light),
                  primaryColor: Color.fromRGBO(11, 20, 35, 1),
                  accentColor: Colors.red,
                  primarySwatch: Colors.blue,
                ),
                home: auth.isAuth
                    ? ProductsPage()
                    : FutureBuilder(
                        future: auth.autoLogin(),
                        builder: (
                          ctx,
                          authResult,
                        ) =>
                            authResult.connectionState ==
                                    ConnectionState.waiting
                                ? SplashScreen()
                                : LoginScreen(),
                      ),
              )),
    );
  }
}
