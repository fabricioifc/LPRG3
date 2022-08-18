import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/repository/refeicao_repository.dart';
import 'package:flutter_firebase_app/routes/routes_app.dart';
import 'package:flutter_firebase_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = Provider.of<AuthService>(context);
    final refeicaoRepo = context.watch<RefeicaoRepository>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text(
                  "Olá Mundo!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.black87,
                      decoration: TextDecoration.none),
                ),
                Text(_auth.usuario!.uid),
                Text(_auth.usuario!.email.toString()),
                ElevatedButton(onPressed: _irParaAbout, child: Text('About')),
                ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, RoutersApp.refeicoesPage),
                    child: Text('Refeições')),
                Text(refeicaoRepo.lista.length.toString())
              ],
            ),
            ElevatedButton(onPressed: _auth.logout, child: Text('Logout'))
          ],
        ),
      ),
    );
  }

  void _irParaAbout() {
    Navigator.pushNamed(context, RoutersApp.aboutPage);
  }
}
