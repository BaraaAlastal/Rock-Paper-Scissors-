import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo.shade900,
        appBar: AppBar(
          title: const Text('Rock Paper Scissors'),
          backgroundColor: Colors.indigo.shade900,
        ),
        body: GamePage(),
      ),
    ),
  );
}

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> images = ['paper_btn', 'rock_btn', 'scissor_btn'];
  late String yourChoice;
  late String robotChoice;
  late String scoreResult;
  int myScore = 0;
  int robotScore = 0;
  double visible = 0;
  @override
  void initState() {
    // TODO: implement initState
    yourChoice = images[0];
    robotChoice = images[0];
    super.initState();
  }

  String determineWinner() {
    setState(() {
      robotChoice = images[Random().nextInt(3)];
      if (yourChoice == robotChoice) {
        scoreResult = 'draw';
      } else if (yourChoice == 'paper_btn' && robotChoice == 'rock_btn') {
        myScore++;
        scoreResult = 'win';
      } else if (yourChoice == 'paper_btn' && robotChoice == 'scissor_btn') {
        robotScore++;
        scoreResult = 'lose';
      } else if (yourChoice == 'rock_btn' && robotChoice == 'paper_btn') {
        robotScore++;
        scoreResult = 'lose';
      } else if (yourChoice == 'rock_btn' && robotChoice == 'scissor_btn') {
        myScore++;
        scoreResult = 'win';
      } else if (yourChoice == 'scissor_btn' && robotChoice == 'paper_btn') {
        myScore++;
        scoreResult = 'win';
      } else if (yourChoice == 'scissor_btn' && robotChoice == 'rock_btn') {
        robotScore++;
        scoreResult = 'lose';
      }
    });
    return scoreResult;
  }

  void showSnackBar(String s) {
    late var snackBar;
    late var colorResult;
    late String snackBarResult;
    if (s == 'win') {
      snackBarResult = 'You Win!';
      colorResult = Colors.green;
    } else if (s == 'lose') {
      snackBarResult = 'You Lost!';
      colorResult = Colors.red;
    } else {
      snackBarResult = 'Its a Draw!';
      colorResult = Colors.white;
    }
    snackBar = SnackBar(
      content: Text(snackBarResult, style: TextStyle(color: colorResult)),
      duration: Duration(seconds: 1),
      action: SnackBarAction(
        textColor: colorResult,
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Score: ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '$myScore',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  child: Text(
                    '  ,',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  width: 20,
                ),
                Text(
                  ' Computer Score: ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '$robotScore',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Column(
              children: [
                Image.asset('images/$robotChoice.png'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Computer',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          AnimatedOpacity(
            opacity: visible,
            duration: const Duration(seconds: 1),
            child: Column(
              children: [
                Text(
                  'Select a Sign: ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            yourChoice = 'paper_btn';
                            String x = determineWinner();
                            showSnackBar(x);
                          });
                        },
                        child: Expanded(
                            child: Image.asset(
                          'images/paper_btn.png',
                          width: 80,
                        )),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            yourChoice = 'rock_btn';
                            String x = determineWinner();
                            showSnackBar(x);
                          });
                        },
                        child: Expanded(
                            child:
                                Image.asset('images/rock_btn.png', width: 80)),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            yourChoice = 'scissor_btn';
                            String x = determineWinner();
                            showSnackBar(x);
                          });
                        },
                        child: Expanded(
                            child: Image.asset('images/scissor_btn.png',
                                width: 80)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      visible = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      side: BorderSide(color: Colors.white, width: 2),
                      primary: Colors.indigo.shade900),
                  child: Text(
                    "Play Now",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      myScore = 0;
                      robotScore = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      side: BorderSide(color: Colors.white, width: 2),
                      primary: Colors.indigo.shade900),
                  child: Text(
                    "Reset Scores",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
