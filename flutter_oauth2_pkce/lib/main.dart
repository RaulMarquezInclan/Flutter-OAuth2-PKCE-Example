import 'package:flutter/material.dart';
import 'package:flutter_oauth2_pkce/ui/profile_page.dart';
import 'package:flutter_oauth2_pkce/ui/product_listings_home.dart';
import 'package:flutter_oauth2_pkce/ui/products_page.dart';
import 'package:flutter_oauth2_pkce/ui/auth_info_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OAuth2 PKCE Flow Demo in Flutter',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => ProductListingsHome(),
            '/profilepage': (context) => ProfilePage(),
            '/productspage': (context) => ProductsPage(),
            '/authinfopage': (context) => AuthInfoPage(),
          },
        );
  }
}