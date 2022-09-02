import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/models/refeicao.dart';
import 'package:flutter_firebase_app/repository/refeicao_repository.dart';
import 'package:flutter_firebase_app/routes/routes_app.dart';
import 'package:provider/provider.dart';

class RefeicoesPage extends StatefulWidget {
  const RefeicoesPage({Key? key}) : super(key: key);

  @override
  State<RefeicoesPage> createState() => _RefeicoesPageState();
}

class _RefeicoesPageState extends State<RefeicoesPage> {
  late RefeicaoRepository repository;

  @override
  Widget build(BuildContext context) {
    repository = context.watch<RefeicaoRepository>();

    return Scaffold(
      appBar: AppBar(title: const Text('Refeições'), actions: [
        IconButton(
            onPressed: () => Navigator.pushNamed(context, RoutersApp.homePage),
            icon: const Icon(Icons.home))
      ]),
      body: FutureBuilder<List<Refeicao>>(
          future: repository.fetchRefeicoes(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Refeicao>> snapshot) {
            // print(snapshot.connectionState);
            // print(snapshot.hasData);

            if (snapshot.connectionState != ConnectionState.done &&
                !snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    void _dismiss() {
                      setState(() {
                        snapshot.data?.removeAt(index);
                      });
                    }

                    return Dismissible(
                      onDismissed: ((direction) async {
                        await repository
                            .remover(repository.lista[index].id.toString());
                        _dismiss();
                      }),
                      background: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                          ),
                          padding: const EdgeInsets.only(right: 14.0),
                          alignment: AlignmentDirectional.centerEnd,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "EXCLUIR",
                                style: TextStyle(color: Colors.white70),
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.white70,
                              )
                            ],
                          )),
                      direction: DismissDirection.endToStart,
                      resizeDuration: const Duration(milliseconds: 200),
                      key: ValueKey(repository.lista[index].id.toString()),
                      // key: UniqueKey(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, "/edit",
                                arguments: repository.lista[index]);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          title: Text(repository.lista[index].name.toString()),
                          subtitle:
                              Text("${repository.lista[index].id.toString()}"),
                          trailing: const Icon(Icons.arrow_right_sharp),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 1.0),
                  itemCount: repository.lista.length);
            }
            return Center(
                child: ListView(
              children: const <Widget>[
                Align(
                    alignment: AlignmentDirectional.center,
                    child: Text('No data available')),
              ],
            ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, RoutersApp.refeicoesFormPage),
        child: const Icon(Icons.add),
      ),
    );
  }
}
