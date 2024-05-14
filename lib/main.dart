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

class Product {
  final String name;
  final String size;
  final double price;
  final String imageUrl;
  int quantity; // Added quantity property

  Product({
    required this.name,
    required this.size,
    required this.price,
    required this.imageUrl,
    this.quantity = 0, // Default quantity is 0
  });
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  final List<Product> _products = [
    Product(
      name: 'Product A',
      size: 'M',
      price: 10.0,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnHukkoHug9pmvlBVN6UEq9veHJr2P92D83mq7K2WDPg&s',
    ),
    Product(
      name: 'Product B',
      size: 'L',
      price: 15.0,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnHukkoHug9pmvlBVN6UEq9veHJr2P92D83mq7K2WDPg&s',
    ),
    Product(
      name: 'Product C',
      size: 'S',
      price: 20.0,
      imageUrl: 'https://storage.apex4u.com/09605A84_1.jpeg',
    ),
  ];

  double _totalAmount = 0.0;

  void updateProductQuantity(Product product, int newQuantity) {
    setState(() {
      product.quantity = newQuantity;
      if (product.quantity == 5) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Added 5 ${product.name} to your bag!'),
              actions: [
                TextButton(
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
      _calculateTotalAmount();
    });
  }

  void _calculateTotalAmount() {
    double total = 0.0;
    for (var product in _products) {
      total += product.quantity * product.price;
    }
    setState(() {
      _totalAmount = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductItem(
            product: _products[index],
            onUpdateQuantity: updateProductQuantity,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Congratulations! You checked out.'),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total Amount: \$$_totalAmount',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function(Product, int) onUpdateQuantity;

  const ProductItem({
    Key? key,
    required this.product,
    required this.onUpdateQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          product.imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Size: ${product.size}'),
            Text('Price: \$${product.price.toString()}'),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (product.quantity > 0) {
                      onUpdateQuantity(product, product.quantity - 1);
                    }
                  },
                ),
                Text('${product.quantity}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    onUpdateQuantity(product, product.quantity + 1);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
