import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int _itemCount = 0;
  double _unitPrice = 10.0;

  void _incrementItemCount() {
    setState(() {
      _itemCount++;
      if (_itemCount % 5 == 0) {
        _showItemAddedDialog();
      }
    });
  }

  void _decrementItemCount() {
    setState(() {
      if (_itemCount > 0) {
        _itemCount--;
      }
    });
  }

  void _showItemAddedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have added 5 items to your bag!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showCheckoutSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Checkout successful.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Item Count: $_itemCount',
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              'Total Amount: \$${_itemCount * _unitPrice}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementItemCount,
                ),
                SizedBox(width: 20.0),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementItemCount,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _showCheckoutSnackbar();
              },
              child: Text('CHECK OUT'),
            ),
          ],
        ),
      ),
    );
  }
}
