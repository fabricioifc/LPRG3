import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/refeicao.dart';
import 'package:flutter_firebase_app/repository/refeicao_repository.dart';
import 'package:flutter_firebase_app/routes/routes_app.dart';
import 'package:provider/provider.dart';

class RefeicaoForm extends StatefulWidget {
  const RefeicaoForm({Key? key}) : super(key: key);

  @override
  State<RefeicaoForm> createState() => _RefeicaoFormState();
}

class _RefeicaoFormState extends State<RefeicaoForm> {
  TextEditingController? nameController;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late RefeicaoRepository repo;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: "Polenta");
  }

  @override
  Widget build(BuildContext context) {
    repo = context.watch<RefeicaoRepository>();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Add Employee"),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Name'),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: inputDecoration.copyWith(
                                hintText: "Enter your Name"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Name';
                              }
                              return null;
                            },
                          ),
                          isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  onPressed: _adicionar,
                                  child: const Text('Adicionar'),
                                ),
                        ])))));
  }

  Future<void> _adicionar() async {
    if (_formKey.currentState!.validate()) {
      try {
        Refeicao objeto = Refeicao(name: nameController?.text);
        setState(() {
          isLoading = true;
        });

        await repo.inserir(objeto);

        setState(() {
          isLoading = false;
        });

        Navigator.pushReplacementNamed(context, RoutersApp.refeicoesPage);
      } on Exception catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }
}

const textStyle = TextStyle(
  color: Colors.white,
  fontSize: 22.0,
  letterSpacing: 1,
  fontWeight: FontWeight.bold,
);

final inputDecoration = InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 2,
        )));
