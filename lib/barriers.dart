import 'package:flutter/material.dart';

class MyBarriers extends StatelessWidget {
  final barrierHieght;
  final barrierWidth;
  final barrierX;
  final isthisBottomBarrier;

  // MyBarriers(
  //   {

  //   this.barrierHieght, this.barrierWidth, this.barrierX, this.isthisBottomBarrier}
  // )
  const MyBarriers(
      {super.key,
      this.barrierHieght,
      this.barrierWidth,
      this.barrierX,
      this.isthisBottomBarrier});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isthisBottomBarrier ? 1 : -1),
      child: Container(
        color: Colors.green,
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHieght / 2,
      ),
    );
  }
}
