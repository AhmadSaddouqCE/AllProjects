import 'dart:math';

extension ContainsAll on List {
  bool containsAll(int x, int y, [z]) {
    if (z == null)
      return contains(x) && contains(y);
    else
      return contains(x) && contains(y) && contains(z);
  }
}

class Player {
  static const x = 'x';
  static const o = 'o';
  static const empty = '';
  static List<int> playerX = [];
  static List<int> playerY = [];
}

class Game {
  void playGame(int index, String activePlayer) {
    if (activePlayer == 'x')
      Player.playerX.add(index);
    else
      Player.playerY.add(index);
  }

  checkWinner() {
    String winner = '';

    if ((Player.playerX.containsAll(0, 1, 2) ||
        Player.playerX.containsAll(3, 4, 5) ||
        Player.playerX.containsAll(6, 7, 8) ||
        Player.playerX.containsAll(0, 3, 6) ||
        Player.playerX.containsAll(1, 4, 7) ||
        Player.playerX.containsAll(2, 5, 8) ||
        Player.playerX.containsAll(0, 4, 8) ||
        Player.playerX.containsAll(2, 4, 6)))
      winner = 'x';
    else if ((Player.playerY.containsAll(0, 1, 2) ||
        Player.playerY.containsAll(3, 4, 5) ||
        Player.playerY.containsAll(6, 7, 8) ||
        Player.playerY.containsAll(0, 3, 6) ||
        Player.playerY.containsAll(1, 4, 7) ||
        Player.playerY.containsAll(2, 5, 8) ||
        Player.playerY.containsAll(0, 4, 8) ||
        Player.playerY.containsAll(2, 4, 6)))
      winner = 'o';
    else
      winner = '';

    return winner;
  }

  
}
