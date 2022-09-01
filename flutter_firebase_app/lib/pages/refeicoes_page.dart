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
  late RefeicaoRepository repo;

  @override
  Widget build(BuildContext context) {
    repo = context.watch<RefeicaoRepository>();

    return Scaffold(
      appBar: AppBar(title: const Text('Refeições'), actions: [
        IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, RoutersApp.refeicoesFormPage),
            icon: const Icon(Icons.add))
      ]),
      body: RefreshIndicator(
        onRefresh: () => repo.fetchRefeicoes(),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: FutureBuilder(builder:
              (BuildContext context, AsyncSnapshot<List<Refeicao>> snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    void _dismiss() {
                      setState(() {
                        snapshot.data?.removeAt(index);
                      });
                    }

                    return Dismissible(
                      onDismissed: ((direction) async {
                        await repo.remover(repo.lista[index].id.toString());
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
                      key: ValueKey(repo.lista[index].id.toString()),
                      // key: UniqueKey(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, "/edit",
                                arguments: repo.lista[index]);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          title: Text(repo.lista[index].name.toString()),
                          subtitle: Text("${repo.lista[index].id.toString()}"),
                          trailing: const Icon(Icons.arrow_right_sharp),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 1.0),
                  itemCount: repo.lista.length);
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
        ),
      ),
    );
  }
}
