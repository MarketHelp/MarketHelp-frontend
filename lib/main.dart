import 'package:flutter/material.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/shops_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/shops': (context) => ShopsScreen(),
        '/products': (context) => ProductsScreen(),
      },
      home: ShopsScreen(),
    );
  }
}
