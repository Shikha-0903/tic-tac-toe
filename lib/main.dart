import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: myapp(),
    debugShowCheckedModeBanner: false,
  ));
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return TicTacToe();
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  bool check = true;
  List<List<String>> twoDList = List.generate(3, (_) => List.generate(3, (_) => ""));
  String winner = "";

  void toggleTurn(int row, int col) {
    if (twoDList[row][col].isEmpty && winner.isEmpty) {
      setState(() {
        twoDList[row][col] = check ? "X" : "O";
        check = !check;
        checkWinner();
      });
    }
  }

  void checkWinner() {
    // Check Rows
    for (int i = 0; i < 3; i++) {
      if (twoDList[i][0] == twoDList[i][1] &&
          twoDList[i][1] == twoDList[i][2] &&
          twoDList[i][0].isNotEmpty) {
        winner = twoDList[i][0];
        showWinnerDialog(winner);
        return;
      }
    }

    // Check Columns
    for (int i = 0; i < 3; i++) {
      if (twoDList[0][i] == twoDList[1][i] &&
          twoDList[1][i] == twoDList[2][i] &&
          twoDList[0][i].isNotEmpty) {
        winner = twoDList[0][i];
        showWinnerDialog(winner);
        return;
      }
    }

    // Check Diagonals
    if (twoDList[0][0] == twoDList[1][1] &&
        twoDList[1][1] == twoDList[2][2] &&
        twoDList[0][0].isNotEmpty) {
      winner = twoDList[0][0];
      showWinnerDialog(winner);
      return;
    }

    if (twoDList[0][2] == twoDList[1][1] &&
        twoDList[1][1] == twoDList[2][0] &&
        twoDList[0][2].isNotEmpty) {
      winner = twoDList[0][2];
      showWinnerDialog(winner);
      return;
    }

    // Check Draw
    if (twoDList.every((row) => row.every((cell) => cell.isNotEmpty)) && winner.isEmpty) {
      winner = "Draw";
      showWinnerDialog(winner);
    }
  }

  void showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(winner == "Draw" ? "Game Draw" : "$winner Wins!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: Text("Play Again"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      twoDList = List.generate(3, (_) => List.generate(3, (_) => ""));
      winner = "";
      check = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic-Tac-Toe",style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: resetGame,
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int row = 0; row < 3; row++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int col = 0; col < 3; col++)
                  GestureDetector(
                    onTap: () => toggleTurn(row, col),
                    child: Container(
                      margin: EdgeInsets.all(8),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          twoDList[row][col],
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
