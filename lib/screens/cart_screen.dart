import 'package:flutter/material.dart';
import 'package:shop_app/providers/cartProvider.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
      var isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cartPro = Provider.of<Cart>(context, listen: false);
    final cartItems = Provider.of<Cart>(context, listen: false).items;
    List<CartItem> carts;
    carts = cartItems.values.toList();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Cart Items",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: (carts.length > 0)
          ? (isLoading)
              ? Center(
                  child: CircularProgressIndicator(color: Colors.teal,),
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Chip(
                          label: Text("₹" + cartPro.totalAmount.toString(),
                              style: TextStyle(fontSize: 26)),
                          backgroundColor: Colors.white,
                        )
                      ],
                    ),
                    Container(
                      height: 400,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: carts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Dismissible(
                              confirmDismiss: (direction) {
                                return showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                          title: Text('Are you sure?'),
                                          content:
                                              Text('Do you want to remove?'),
                                          actions: [
                                            FlatButton(
                                              textColor: Colors.red,
                                              child: Text('No'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                            ),
                                            FlatButton(
                                              textColor: Colors.red,
                                              child: Text('Yes'),
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                            )
                                          ],
                                        ));
                              },
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                cartPro.deleteItem(carts[index].id);
                              },
                              key: ValueKey(carts[index].id),
                              background: Container(
                                color: Colors.red,
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.all(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    color: Colors.white,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: ListTile(
                                          contentPadding: EdgeInsets.all(10),
                                          tileColor: Colors.transparent,
                                          leading: Image.network(
                                            carts[index].img,
                                            width: 80,
                                            fit: BoxFit.cover,
                                            alignment:
                                                FractionalOffset.topCenter,
                                          ),
                                          trailing: IconButton(
                                            splashColor: Colors.red,
                                            splashRadius: 24,
                                            icon: Icon(
                                              Icons.delete_outline,
                                              size: 34,
                                              color: Colors.red,
                                            ),
                                            color: Colors.red,
                                            onPressed: () {
                                              cartPro
                                                  .deleteItem(carts[index].id);
                                            },
                                          ),
                                          title: Text(
                                            carts[index].title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Quantity : ${carts[index].quantity}',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "Size : L",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Cart is Empty ",
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 40,
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Shop Now",
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  color: Colors.white,
                )
              ],
            )),
      floatingActionButton: (carts.length > 0)
          ? FloatingActionButton.extended(
              backgroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                Provider.of<Orders>(context, listen: false)
                    .addOrder(carts, cartPro.totalAmount)
                    .then((value) {
                  cartPro.clearItems();
                  setState(() {
                  isLoading = false;
                });
                });
              },
              isExtended: true,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
                size: 22,
              ),
              label: Text(
                'Order Now',
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            )
          : SizedBox(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
