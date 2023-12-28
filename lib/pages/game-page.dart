import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/components/colors.dart';

class GamePage extends StatefulWidget {
  GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', '',];
  List<int> matchedBoxes = [];
  String resultDeclare = '';
  int playerOScore = 0;
  int playerXScore = 0;
  int filledBoxes = 0;
  bool playerWon = false;
  int attempts = 0;

  static const maxTime = 30;
  int seconds = maxTime;
  Timer? timer;

  static var customeFontWhite = GoogleFonts.coiny(
      textStyle:
          const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 28));

  void startTimer () {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
      if (seconds > 0) {
        seconds--;
      } else {
        stopTimer();
      }
    });
     });
  }

  void stopTimer () {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer () => seconds = maxTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('PlayerO', style: customeFontWhite,),
                          Text(playerOScore.toString(), style: customeFontWhite,)
                        ],
                      ),
                      SizedBox(width: 20,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('PlayerX', style: customeFontWhite,),
                          Text(playerXScore.toString(), style: customeFontWhite,)
                        ],
                      ),
                    ],
                  ),
                ),
                
                ),
              Expanded(
                flex: 5,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                   itemBuilder: (BuildContext context, index) {
                   return GestureDetector(
                    onTap: () {
                      _tapped(index,);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 5,
                        color: ThemeColors.primaryColor
                      ),
                      color: matchedBoxes.contains(index) 
                            ? ThemeColors.winColor 
                            : ThemeColors.secondaryColor,
                      ),
                      child: Center(
                        child: Text( displayXO[index] ,style: GoogleFonts.coiny(
                          textStyle: TextStyle(fontSize: 64, color: ThemeColors.primaryColor)
                        ),),
                      ),
                    ),
                   );
        
                   }
                   ),
                
                ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(resultDeclare, style: customeFontWhite,),
                      SizedBox(height: 20,),
                      _buildTimer()
                    ],
                  ),
                )
                ),
            ],
          ),
        ));
  }

  void _tapped(int index,) {
    final isRunning = timer == null ? false : timer!.isActive;
    if(isRunning) {
      setState(() {
      if(oTurn && displayXO[index] == '') {
        displayXO[index] = 'O';
        filledBoxes++;
      } else if(!oTurn && displayXO[index] == '') {
        displayXO[index] = 'X';
        filledBoxes++;
      }
    });
    oTurn = !oTurn;
    _checkWinner();
    }
  }

  void _checkWinner() {

    //check 1st row
    if(displayXO[0] == displayXO[1] && 
       displayXO[0] == displayXO[2] &&
       displayXO[0] != '') {
        setState(() {
          resultDeclare = 'Player ' + displayXO[0] + ' Won!' ;
          matchedBoxes.addAll([0, 1, 2]);
          stopTimer();
          updateScore(displayXO[0]);
        });
    }
    //check 2nd row
    if(displayXO[3] == displayXO[4] && 
       displayXO[3] == displayXO[5] &&
       displayXO[3] != '') {
        setState(() {
          resultDeclare = 'Player ' + displayXO[3] + ' Won!' ;
          matchedBoxes.addAll([3, 4, 5]);
          stopTimer();
          updateScore(displayXO[3]);          
        });
    }
    //check 3rd row
    if(displayXO[6] == displayXO[7] && 
       displayXO[6] == displayXO[8] &&
       displayXO[6] != '') {
        setState(() {
          resultDeclare = 'Player ' + displayXO[6] + ' Won!' ;
          matchedBoxes.addAll([6, 7, 8]);
          stopTimer();
          updateScore(displayXO[6]);         
        });
    }
    //check 1st column
    if(displayXO[0] == displayXO[3] && 
       displayXO[0] == displayXO[6] &&
       displayXO[0] != '') {
        setState(() {
          resultDeclare = 'Player ' + displayXO[0] + ' Won!' ;
          matchedBoxes.addAll([0, 3, 6]);
          stopTimer();
          updateScore(displayXO[0]);         
        });
    }
    //check 2nd column
    if(displayXO[1] == displayXO[4] && 
       displayXO[1] == displayXO[7] &&
       displayXO[1] != '') {
        setState(() {
          resultDeclare = 'Player ' + displayXO[1] + ' Won!' ;
          matchedBoxes.addAll([1, 4, 7]);
          stopTimer();
          updateScore(displayXO[1]);         
        });
    }
    //check 3rd column
    if(displayXO[2] == displayXO[5] && 
       displayXO[2] == displayXO[8] &&
       displayXO[2] != '') {
        setState(() {
          resultDeclare = 'Player ' + displayXO[2] + ' Won!' ;
          matchedBoxes.addAll([2, 5, 8]);
          stopTimer();
          updateScore(displayXO[2]);        
        });
    }
    //check diagnol
    if(displayXO[0] == displayXO[4] && 
       displayXO[0] == displayXO[8] &&
       displayXO[0] != '') {
        setState(() {
          resultDeclare = 'Player ' + displayXO[0] + ' Won!' ;
          matchedBoxes.addAll([0, 4, 8]);
          stopTimer();
          updateScore(displayXO[0]);      
        });
    }
    if(displayXO[2] == displayXO[4] && 
       displayXO[2] == displayXO[6] &&
       displayXO[2] != '') {
        setState(() {
          resultDeclare = 'Player ' + displayXO[2] + ' Won!' ;
          matchedBoxes.addAll([2, 4, 6]);
          stopTimer();
          updateScore(displayXO[2]);
        });
    }

    if(!playerWon && filledBoxes == 9) {
      setState(() {
        resultDeclare = 'Tied';
      });
    }
  }

  void updateScore(String winner) {
    if(winner == 'O') {
      playerOScore++;
    } else if(winner == 'X') {
      playerXScore++;
    }
    playerWon = true;
  }

  void _clearBoard() {
    setState(() {
      for(int i=0 ; i < 9 ; i++) {
        displayXO[i] = '';
      }
      resultDeclare = '';
    });
    filledBoxes = 0;
    matchedBoxes = [];
  }

  Widget _buildTimer () {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning ? 
    SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: 1 - seconds / maxTime,
            valueColor: AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 8,
            backgroundColor: ThemeColors.accentColor,
          ),
          Center(
            child: Text('$seconds', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white) ,),
          )
        ],
      ),
    ) : 
    ElevatedButton(onPressed: () {
      startTimer();
      _clearBoard();
      attempts++;
      },
    style: ElevatedButton.styleFrom(backgroundColor: ThemeColors.secondaryColor, padding: EdgeInsets.symmetric(horizontal: 20)),
    child: attempts == 0 ? Text('Start', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),) : Icon(Icons.replay_outlined, color: ThemeColors.primaryColor,));
  }
}
