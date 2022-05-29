import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/cartProvider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_card.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var loading = false;
  var _isinit = true;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      if(!(Provider.of<Products>(context).items.length>0))
      {
      loading = true;
      Provider.of<Products>(context).fetchAndSetProducts().then((value) => loading=false);
      }
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  
  Future<void> _refreshProducts() async {
    await Provider.of<Products>(context,listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final prod = productsData.items;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "ByteKart",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.count().toString(),
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => CartScreen()));
                },
                icon: Icon(
                  Icons.shopping_cart,
                  size: 26,
                )),
          )
        ],
      ),
      body: loading? Center(child: CircularProgressIndicator(color: Colors.teal,),) : (prod.length > 0)
          ? RefreshIndicator(
            onRefresh: _refreshProducts,
            child: GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: prod.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                    value: prod[index], child: ProductCard()),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
              ),
          )
          : Center(
              child: Text(
                "No Products Found",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
    );
  }

}
