import 'package:electronic_shop/providers/products_provider.dart';
import 'package:electronic_shop/screens/bottom_navigation_screen.dart';
import 'package:electronic_shop/screens/cart_screen.dart';
import 'package:electronic_shop/screens/checkout_screen.dart';
import 'package:electronic_shop/screens/products_screen.dart';
import 'package:electronic_shop/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ProductsProvider>(create: (_) => ProductsProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Electronic Shop',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomNavigationScreen(),
        '/products': (context) => const ProductsScreen(),
        '/cart': (context) => const CartScreen(),
        '/checkout': (context) => const CheckoutScreen(),
      },
    );
  }
}
