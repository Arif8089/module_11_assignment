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

  Product({
    required this.name,
    required this.size,
    required this.price,
    required this.imageUrl,
  });
}

class ShoppingCart extends StatelessWidget {
  final List<Product> _products = [
    Product(
      name: 'Product A',
      size: 'M',
      price: 10.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Product B',
      size: 'L',
      price: 15.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Product(
      name: 'Product C',
      size: 'S',
      price: 20.0,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductItem(product: _products[index]);
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

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
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart),
          onPressed: () {
            // Add to cart functionality
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added ${product.name} to cart!'),
              ),
            );
          },
        ),
      ),
    );
  }
}
