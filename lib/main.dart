import 'package:flutter/material.dart';
import 'package:notepad/database/db_handler.dart';
import 'package:notepad/provider/notes_provider.dart';
import 'package:notepad/provider/theme_provider.dart';
import 'package:notepad/screens/notes_home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers:
      [
        ChangeNotifierProvider(create: (context)=>NotesProvider(dbHelper: DbHelper())),
        ChangeNotifierProvider(create: (context)=>ThemeProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isTheme= Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notepad',
      theme: isTheme.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: const NotesHomePageScreen(),
    );
  }
}
