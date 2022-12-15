import 'dart:async';

import 'package:flappy_bird_flutter/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bird Variables

  static double birdY = 0;
  double intialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9;
  double velocity = 3.5;

  //game settings
  bool gamehasStarted = false;

  //barrier variables
  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5;
  List<List<double>> barrierHieght = [
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void startGame() {
    gamehasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = intialPos - height;
      });

      //check if bird is hitting top or bottom
      bool birdIsDead() {
        if (birdY < -1 || birdY > 1) {
          return true;
        }
        return false;
      }

      //if bird is ded
      if (birdIsDead()) {
        timer.cancel();
        gamehasStarted = false;
        _showDialog();
      }
      //check if the birt is hitting barriers

      time += 0.1;
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gamehasStarted = false;
      time = 0;
      intialPos = birdY;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Center(
              child: Column(
                children: [
                  // Image.asset(
                  //   // 'lib/images/img2.png',
                  //   width: 110,
                  //   height: 110,
                  // ),
                  Text(
                    'GAME OVER',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.white,
                      child: Text(
                        'PLAY AGAIN',
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void jump() {
    setState(() {
      time = 0;
      intialPos = birdY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gamehasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(
                        birdY: birdY,
                      ),
                      Container(
                        alignment: Alignment(0, -0.5),
                        child: Text(
                          gamehasStarted ? '' : 'TAP TO PLAY',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 24),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
