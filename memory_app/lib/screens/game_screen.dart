import 'package:flutter/material.dart';
import 'package:memory_app/utils/game.dart';
import 'package:memory_app/widgets/score_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key, required String title}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Game _game = Game();
  int tries = 0;
  int score = 0;
  int? clicked;

  @override
  void initState() {
    super.initState();
    _game.startGame();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Opacity(
          opacity: _game.cardCountRemaining == 0 ? 0.5 : 1.0,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Memory Game',
                      style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    InkWell(
                      splashColor: Colors.white,
                      onTap: () {
                        resetGame();
                      },
                      child: Icon(Icons.refresh, color: Colors.black87),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    scoreBoard("Tentativas", tries.toString()),
                    scoreBoard("Pontuação", score.toString())
                  ],
                ),
                SizedBox(
                    height: screenWidth,
                    width: screenWidth,
                    child: GridView.builder(
                        itemCount: _game.images!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // Caso clique duas vezes na mesma figura, retornar
                                if (clicked == index) {
                                  return;
                                }
                                clicked = index;
                                bool? acertou = _game.checkAnswer(index);
                                handleAcertou(acertou);

                                // Verificar se terminou
                                checkEndGame();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                      opacity: 0.9,
                                      image: AssetImage(_game.images![index]),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        }))
              ]),
        ),
      ),
    );
  }

  void handleAcertou(bool? acertou) {
    if (acertou != null) {
      tries++;
      if (acertou == true) {
        score += 100;
        _game.cardCountRemaining--;
      } else {
        Future.delayed(Duration(milliseconds: 700), () {
          setState(() {
            _game.clearCheckedCards();
          });
        });
      }
    }
  }

  void resetGame() {
    setState(() {
      tries = 0;
      score = 0;

      _game.startGame();
    });
  }

  void checkEndGame() {
    // Se não tiver mais cartas, então terminou
    if (_game.cardCountRemaining == 0) {
      var snackBar = const SnackBar(content: Text('Terminou!!!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
