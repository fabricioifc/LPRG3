import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/pages/home_page.dart';
import 'package:flutter_firebase_app/pages/login_page.dart';
import 'package:flutter_firebase_app/routes/routes_app.dart';
import 'package:flutter_firebase_app/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  // https://github.com/drantunes/cripto_moedas/tree/semana5/lib
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => AuthService())],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: const AuthCheck(),
      initialRoute: RoutersApp.homePage,
      onGenerateRoute: RoutersApp.generateRoute,
    );
  }
}
