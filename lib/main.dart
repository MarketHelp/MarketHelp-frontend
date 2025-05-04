import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/bloc/search_box_shop/search_box_shop_bloc.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/shops_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/products_screen.dart';
import 'package:markethelp_frontend/feature/markethelp/presentation/widgets/screens/analiytics_screen.dart';
import 'package:markethelp_frontend/injector.dart';

void main() async {
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final bool isShopsScreenHome = true;

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
        '/analytics': (context) => AnalyticsScreen(),
      },
      home:
          isShopsScreenHome
              ? BlocProvider(
                create: (context) => SearchBoxShopBloc(),
                child: ShopsScreen(),
              )
              : ProductsScreen(),
    );
  }
}
