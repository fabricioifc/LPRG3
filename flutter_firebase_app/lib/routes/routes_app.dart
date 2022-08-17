import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/pages/about_page.dart';
import 'package:flutter_firebase_app/pages/home_page.dart';
import 'package:flutter_firebase_app/pages/login_page.dart';
import 'package:flutter_firebase_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class RoutersApp {
  static const String homePage = '/';
  static const String aboutPage = '/about';
  static const String loginPage = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => AuthCheck());
      case aboutPage:
        return MaterialPageRoute(builder: (_) => AboutPage());
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return LoginPage();
    } else {
      return const HomePage();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
