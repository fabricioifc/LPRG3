import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/refeicao.dart';

class RefeicaoRepository extends ChangeNotifier {
  List<Refeicao> _lista = [];

  List<Refeicao> get lista => _lista;

  Future fetchRefeicoes() async {
    var db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection('refeicoes').get();
    _lista = snapshot.docs.map((e) => Refeicao.fromMap(e)).toList();

    notifyListeners();
  }

  inserir(Refeicao objeto) async {
    var db = FirebaseFirestore.instance;
    await db.collection('refeicoes').add(objeto.toMap());
  }

  Future<void> remover(String id) async {
    var db = FirebaseFirestore.instance;
    await db.collection('refeicoes').doc(id).delete();
  }
}
