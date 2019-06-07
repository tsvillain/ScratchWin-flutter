import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // import asset image
  AssetImage circle = AssetImage('images/circle.png');
  AssetImage lucky = AssetImage('images/rupee.png');
  AssetImage unlucky = AssetImage('images/sadFace.png');

  // get an array

  List<String> itemArray;
  int luckyNumber;
  int counter = 4;
  String status = "";

  //init array
  @override
  void initState() {
    super.initState();
    this.status = "Attempt Left: ${counter + 1}";
    itemArray = List<String>.generate(25, (index) => "empty");
    generateRandomNumber();
  }

  generateRandomNumber() {
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    });
  }

  //get image
  AssetImage getImage(int index) {
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
        return lucky;
        break;
      case "unlucky":
        return unlucky;
        break;
    }
    return circle;
  }

  //play game()
  playGame(int index) async {
    if (luckyNumber == index) {
      setState(() {
        itemArray[index] = "lucky";
      });
    } else {
      setState(() {
        itemArray[index] = "unlucky";
      });
    }
    if (this.counter > 0) {
      if (itemArray[index] == "lucky") {
        setState(() {
          this.status = "You Won";
        });
        this.showAll();
        this.counter = null;
        await Future.delayed(Duration(seconds: 3));
        this.resetGame();
      } else {
        setState(() {
          counter--;
          this.status = "Attempt Left: ${counter + 1}";
        });
      }
    } else if (counter == 0) {
      if (itemArray[index] == "lucky") {
        setState(() {
          this.status = "You Won";
        });
      } else {
        setState(() {
          this.status = 'Game Over';
        });
      }
      this.showAll();
      await Future.delayed(Duration(seconds: 3));
      this.resetGame();
    }
  }

  //win logic
  winLogin() {}
  //showall
  showAll() {
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }
  //reset all

  resetGame() {
    setState(() {
      itemArray = List<String>.filled(25, "empty");
      this.counter = 4;
      this.status = "Attempt Left: ${counter + 1}";
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch and Win'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0),
              itemCount: itemArray.length,
              itemBuilder: (BuildContext context, int i) => SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        this.playGame(i);
                      },
                      child: Image(image: this.getImage(i)),
                    ),
                  ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 2.0),
            child: Text(status,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                this.showAll();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Show All',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: () {
                this.resetGame();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Reset',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 2.0),
            color: Colors.black,
            child: Text('Learncodeonline.in',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
