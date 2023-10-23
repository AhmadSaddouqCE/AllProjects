import 'package:flutter/material.dart';
import 'package:sara_music/Games/GamePage.dart';
import 'package:sara_music/Games/game_logic.dart';
import 'package:sara_music/Screens/bottom_bar.dart';
import 'package:sara_music/Shop/colors.dart';

class Tic_Tac_Toe extends StatefulWidget {
  const Tic_Tac_Toe({Key? key}) : super(key: key);

  @override
  State<Tic_Tac_Toe> createState() => _Tic_Tac_ToeState();
}

class _Tic_Tac_ToeState extends State<Tic_Tac_Toe> {
  String activePlayer = 'x';

  bool gameOver = false;

  int turn = 0;

  String result = 'result';

  Game game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
                  ...firstBlock(),
                  _expanded(context),
                  ...lastBlock(),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...firstBlock(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        ...lastBlock(),
                      ],
                    ),
                  ),
                  _expanded(context),
                ],
              ),
      ),
    );
  }

  List<Widget> firstBlock() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Gamepage()));
              },
              child: Icon(Icons.arrow_back, color: white, size: 35),
            ),
          ),
        ],
      ),
      Text(
        'it \'s $activePlayer turn'.toUpperCase(),
        style: const TextStyle(
          fontSize: 52,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ];
  }

  Expanded _expanded(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        children: List.generate(
          9,
          (index) => InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: gameOver ? null : () => _onTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  Player.playerX.contains(index)
                      ? 'x'
                      : Player.playerY.contains(index)
                          ? 'o'
                          : '',
                  style: TextStyle(
                    fontSize: 52,
                    color: Player.playerX.contains(index)
                        ? Colors.blue
                        : Colors.pink,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> lastBlock() {
    return [
      Text(
        result,
        style: const TextStyle(
          fontSize: 42,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.replay),
        onPressed: () {
          setState(() {
            Player.playerX = [];

            Player.playerY = [];

            activePlayer = 'x';

            gameOver = false;

            turn = 0;

            result = '';

            game = Game();
          });
        },
        label: const Text('Repeat the game'),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).splashColor),
        ),
      ),
      const SizedBox(height: 30),
    ];
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerY.isEmpty || !Player.playerY.contains(index))) {
      game.playGame(index, activePlayer);

      updateState();
    }
  }

  void updateState() {
    return setState(() {
      activePlayer = (activePlayer == 'x') ? 'o' : 'x';
      turn++;
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        gameOver = true;
        result = '$winnerPlayer is the winner';
      } else if (!gameOver && turn == 9) {
        result = 'It\'s Draw!';
      }
    });
  }
}
