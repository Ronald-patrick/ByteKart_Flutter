import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class EditProducts extends StatefulWidget {
  Product product;

  EditProducts(this.product);
  @override
  _EditProductsState createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  final _priceFocus = FocusNode();
  final _descrFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imgUrlFocus = FocusNode();
  final formkey = GlobalKey<FormState>();
    var isLoading = false;

  var isInit = true;
  var _edittedProduct =
      Product(id: null, title: '', description: '', price: 0, imgurl: '',isfav: false);

  @override
  void dispose() {
    _priceFocus.dispose();
    _descrFocus.dispose();
    _imgUrlFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    _imageUrlController.text = widget.product.imgurl;
    final provider = Provider.of<Products>(context);

    void _saveForm() {
      if (formkey.currentState.validate()) {
        formkey.currentState.save();

        setState(() {
          isLoading = true;
        });

        provider.updateProducts(_edittedProduct).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Product Edited  !",
              style: TextStyle(fontSize: 20),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.teal,
          ));

          setState(() {
            isLoading = false;
          });

          Navigator.of(context).pop();
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Error Editing Product !",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ));

          setState(() {
            isLoading = false;
          });

          Navigator.of(context).pop();
          return;
        });
      }
      return;
    }

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Edit Product'),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(color: Colors.teal,),) : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                initialValue: widget.product.title,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Provide Value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _edittedProduct = Product(
                      id: widget.product.id,
                      title: value,
                      description: _edittedProduct.description,
                      price: _edittedProduct.price,
                      imgurl: _edittedProduct.imgurl,
                      isfav: widget.product.isfav);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Cannot be Empty';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Enter a valid value';
                  }
                  return null;
                },
                initialValue: widget.product.price.toString(),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descrFocus);
                },
                onSaved: (value) {
                  _edittedProduct = Product(
                      id: widget.product.id,
                      title: _edittedProduct.title,
                      description: _edittedProduct.description,
                      price: double.parse(value),
                      imgurl: _edittedProduct.imgurl,
                      isfav: widget.product.isfav);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                focusNode: _descrFocus,
                maxLines: 3,
                initialValue: widget.product.description,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Cannot be Empty';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 characters long';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _edittedProduct = Product(
                      id: widget.product.id,
                      title: _edittedProduct.title,
                      description: value,
                      price: _edittedProduct.price,
                      imgurl: _edittedProduct.imgurl,
                      isfav: widget.product.isfav);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: _imageUrlController.text.isEmpty
                        ? Text(
                            'Enter a URL',
                            textAlign: TextAlign.center,
                          )
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imgUrlFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Cannot be Empty';
                        }
                        if (!value.startsWith('http') ||
                            !value.startsWith('https')) {
                          return 'Enter a valid url';
                        }
                        return null;
                      },
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onFieldSubmitted: (_) => _saveForm(),
                      onSaved: (value) {
                        _edittedProduct = Product(
                          id: widget.product.id,
                          title: _edittedProduct.title,
                          description: _edittedProduct.description,
                          price: _edittedProduct.price,
                          imgurl: value,
                          
                      isfav: widget.product.isfav
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
