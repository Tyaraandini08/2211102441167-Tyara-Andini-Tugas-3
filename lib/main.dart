import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penjualan',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PenjualanScreen(),
    );
  }
}

class PenjualanScreen extends StatefulWidget {
  @override
  _PenjualanScreenState createState() => _PenjualanScreenState();
}

class _PenjualanScreenState extends State<PenjualanScreen> {
  final List<Map<String, dynamic>> produkList = [
    {
      'nama': 'Parfum Zara',
      'harga': 299000,
      'rating': 4.5,
      'gambar': 'https://static.zara.net/assets/public/8cf5/c492/9f1a470c8bce/9d27c2800205/1688374457989/1688374457989.jpg?ts=1701388806814&w=824',
    },
    {
      'nama': 'Parfum Scarllet',
      'harga': 1500000,
      'rating': 4.2,
      'gambar': 'https://soc-newplatform.s3.ap-southeast-1.amazonaws.com/productmaster-1540454132.jpg',
    },
    {
      'nama': 'Pink Miniso',
      'harga': 79000,
      'rating': 4.8,
      'gambar': 'https://img.id.my-best.com/product_images/80891b04a5b3fbb6b5da1b8ed2de2972.png?ixlib=rails-4.3.1&q=70&lossless=0&w=800&h=800&fit=clip&s=2c6da7ac68dd0f8c1f9fd1c2d996bbf7',
    },
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjualan'),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: produkList.length,
        itemBuilder: (context, index, animation) {
          final produk = produkList[index];
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: ProdukCard(produk: produk),
          );
        },
      ),
    );
  }
}

class ProdukCard extends StatelessWidget {
  final Map<String, dynamic> produk;

  ProdukCard({required this.produk});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.teal.shade200,
            Colors.teal.shade400,
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(produk['gambar']),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produk['nama'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Rp ${produk['harga'].toString()}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      produk['rating'].toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.teal,
                        ),
                        onPressed: () {
                          // Aksi ketika tombol "Beli Sekarang" ditekan
                        },
                        child: Text('Beli Sekarang'),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white),
                        ),
                        onPressed: () {
                          // Aksi ketika tombol "Tambah ke Keranjang" ditekan
                        },
                        child: Text('Tambah ke Keranjang'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}