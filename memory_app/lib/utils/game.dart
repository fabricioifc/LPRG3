class Game {
  final int cardCount = 3;
  late int cardCountRemaining;

  final String hiddenCardPath = 'assets/images/memory-game.png';
  List<String> cardList = [
    'assets/images/darth-vader.png',
    'assets/images/death-star.png',
    'assets/images/light-saber.png',
  ];

  List<String>? images;
  List<String> duplicatedCardList = [];
  List<String> checkedCardListScore = [];

  List<Map<int, String>> matchCheck = [];

  void startGame() {
    cardCountRemaining = cardCount;
    images = List.generate(cardCount * 2, (index) => hiddenCardPath);
    duplicatedCardList = [...cardList, ...cardList];

    duplicatedCardList.shuffle();
    checkedCardListScore = [];
  }

  bool? checkAnswer(int index) {
    // Se clicou em alguma imagem que já acertou, então apenas retornar
    if (checkedCardListScore.contains(duplicatedCardList[index])) {
      return null;
    }

    images![index] = duplicatedCardList[index];
    matchCheck.add({index: duplicatedCardList[index]});

    if (matchCheck.length == 2) {
      if (matchCheck[0].values.first == matchCheck[1].values.first) {
        // Acertou
        checkedCardListScore.add(matchCheck[0].values.first);
        matchCheck.clear();
        return true;
      } else {
        // Errou
        return false;
      }
    }
    // Se retornar null, então ainda não selecionou duas figuras
    return null;
  }

  void clearCheckedCards() {
    images![matchCheck[0].keys.first] = hiddenCardPath;
    images![matchCheck[1].keys.first] = hiddenCardPath;
    matchCheck.clear();
  }
}
