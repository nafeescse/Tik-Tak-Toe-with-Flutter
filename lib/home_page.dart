import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tiktak/custom_dialog.dart';
import 'package:tiktak/game_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<GameButton> buttonsList;
  var player1;
  var player2;
  var activeplayer;



  @override
  void initState() {
    super.initState();

    buttonsList = doInit();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        backgroundColor: Colors.lightBlueAccent,
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
      ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
              child: new GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 19.0,
                    mainAxisSpacing: 19.0),
                itemCount: buttonsList.length,
                itemBuilder: (context, i) => new SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    onPressed: buttonsList[i].enabled
                        ? () => playGame(buttonsList[i])
                        : null,
                    child: new Text(
                      buttonsList[i].text,
                      style: new TextStyle(
                          color: Colors.white, fontSize: 20.0),
                    ),
                    color: buttonsList[i].bg,
                    disabledColor: buttonsList[i].bg,
                  ),
                ),
              ),
            ),
            new RaisedButton(
              child: new Text(
                "Reset",
                style: new TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.red,
              padding: const EdgeInsets.all(20.0),
              onPressed: resetGame,
            )
          ],
        ));
  }
  void autoPlay() {
    var emptyCells = [];
    var list = new List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if (!(player1.contains(cellID) || player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }

    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length-1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((p)=> p.id == cellID);
    playGame(buttonsList[i]);

  }

  List<GameButton> doInit() {
    player1 = [];
    player2 = [];
    activeplayer = 1;


  var allGamesButton = [
    GameButton(id: 1),
    GameButton(id: 2),
    GameButton(id: 3),
    GameButton(id: 4),
    GameButton(id: 5),
    GameButton(id: 6),
    GameButton(id: 7),
    GameButton(id: 8),
    GameButton(id: 9),
  ];

  return allGamesButton;
}

void playGame(GameButton gb){
    setState(() {
      if(activeplayer == 1){
        gb.text = "X";
        gb.bg = Colors.red;
        activeplayer = 2;
        player1.add(gb.id);
      }
      else{
          gb.text = "0";
          gb.bg = Colors.lightGreenAccent;
          activeplayer = 1;
          player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if(winner == -1){
        if(buttonsList.every((p) => p.text != "")){
          showDialog(
              context: context,
              builder: (context) => new CustomDialog("Game Over", "Press the reset button to start again", resetGame));
        }
        else{
          activeplayer == 2 ? autoPlay() : null;
        }
      }

      }
    );
}

int checkWinner(){
    var winner = -1 ;

    if(player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if(player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }
    if(player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if(player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }
    if(player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if(player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }
    if(player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if(player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }
    if(player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if(player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }
    if(player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if(player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    if(player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if(player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }
    if(player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if(player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }
    if(winner != -1){
      if(winner == 1){
        showDialog(
          context: context,
          builder: (_) => new CustomDialog("Player1 Won -- Party Oito", "Press the reset button to start again", resetGame));
      }
      else{
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Player2 Won -- Abar Khelo ", "Press the reset button to start again", resetGame));
      }

      }

    return winner;
}

void resetGame() {
    if(Navigator.canPop(context)){
      Navigator.pop(context);
      setState(() {
        buttonsList = doInit();
      });
    }
    else{setState(() {
      buttonsList = doInit();
    });

  }
}}
