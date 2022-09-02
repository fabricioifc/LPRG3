import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:terceiro_app/providers/dark_theme_provider.dart';
import 'package:terceiro_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DarkThemeProvider darkThemeProvider = DarkThemeProvider();

  runApp(ChangeNotifierProvider(
    create: (context) => darkThemeProvider,
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      // themeMode: ThemeMode.system,
      themeMode: themeProvider.theme,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
