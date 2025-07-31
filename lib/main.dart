import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/shopping_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[50],
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
          accentColor: Colors.amberAccent,
        ).copyWith(secondary: Colors.amberAccent),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
      ),
      home: const ShoppingListScreen(),
    );
  }
}
