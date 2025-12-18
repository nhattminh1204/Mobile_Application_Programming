import 'package:day01/api.dart';
import 'package:day01/model/product.dart';
import 'package:flutter/material.dart';

import 'package:day01/screens/cart_screen.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1A1D1F)),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
             Padding(
              padding: const EdgeInsets.only(top: 0),
              child: FutureBuilder<List<Product>>(
                future: test_api.getAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.blue[400]),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.blue[700]),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No products found',
                        style: TextStyle(color: Colors.blue[700]),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: EdgeInsets.all(12),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Product product = snapshot.data![index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.1),
                              blurRadius: 15,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.blue[50]!, Colors.white],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Image.network(
                                          product.image,
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) =>
                                              Icon(
                                                Icons.image_not_supported,
                                                size: 40,
                                                color: Colors.blue[300],
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    right: 6,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(0.2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.favorite_border,
                                          size: 12,
                                          color: Colors.blue[400],
                                        ),
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('💖 Added to favorites'),
                                              backgroundColor: Colors.blue[400],
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                        },
                                        padding: EdgeInsets.all(4),
                                        constraints: BoxConstraints(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                        color: Colors.grey[800],
                                        height: 1.2,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber,
                                          size: 12,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          '${product.rating.rate}',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: Colors.blue[600],
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 24,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text('🛒 Added to cart!'),
                                                  backgroundColor: Colors.blue[400],
                                                  duration: Duration(seconds: 1),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue[400],
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              padding: EdgeInsets.zero,
                                              elevation: 3,
                                            ),
                                            child: Icon(
                                              Icons.add_shopping_cart_rounded,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // Navigation Controls
            // Navigation Controls removed
          ],
        ),
      ),
    );
  }
}
