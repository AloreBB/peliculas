import 'package:flutter/material.dart';

import 'package:peliculas/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: 'home',
      routes: {
        'home':( _ ) => const HomeScreen(),
        'detail':( _ ) => const DetailsScreen(),
      },
      theme: ThemeData.light( useMaterial3: true ).copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.indigo,
          elevation: 0,
          titleTextStyle: TextStyle( color: Colors.white, fontSize: 20),
          centerTitle: true,
        )
      ),
    );
  }
}