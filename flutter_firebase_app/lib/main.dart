import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/account.dart';
import 'package:flutter_firebase_app/models/refeicao.dart';
import 'package:flutter_firebase_app/repository/refeicao_repository.dart';
import 'package:flutter_firebase_app/routes/routes_app.dart';
import 'package:flutter_firebase_app/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  // https://github.com/drantunes/cripto_moedas/tree/semana5/lib
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // var accountsRef = FirebaseFirestore.instance.collection('accounts');
  // accountsRef.add(Account(sigla: "NU", name: 'Nubank', icone: 'bank').toJson());
  // RefeicaoRepository repo = RefeicaoRepository();
  // repo.inserir(Refeicao(
  //     day_of_week: 'Segunda-Feira',
  //     description: 'descrição',
  //     image: 'imagem',
  //     name: 'Polenta'));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => RefeicaoRepository()),
    ],
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
