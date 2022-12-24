import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String playerx = 'x';
  static const String playery = 'y';

  late String currentplayer;
  late bool gameend;
  late List<String> occupied;

  int x = 1;
  @override
  void initState() {
    initialgame();
    super.initState();
  }

  initialgame() {
    currentplayer = playerx;
    gameend = false;
    occupied = ['', '', '', '', '', '', '', '', ''];
  }

  changeplayer() {
    if (currentplayer == playerx) {
      currentplayer = playery;
    } else {
      currentplayer = playerx;
    }
  }

  gamewinner() {
    List<List<int>> winnerlist = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var i in winnerlist) {
      String positionwin0 = occupied[i[0]];
      String positionwin1 = occupied[i[1]];
      String positionwin2 = occupied[i[2]];
      if (positionwin0.isNotEmpty) {
        if (positionwin0 == positionwin1 && positionwin0 == positionwin2) {
          showmessage('player $positionwin0 won');
          gameend = true;
        }
      }
    }
  }

  gameended() {
    bool draw = true;
    for (var occuipiedplayer in occupied) {
      if (occuipiedplayer.isEmpty) {
        draw = false;
      }
    }
    if (draw) {
      showmessage('game Ended');
      
    }
  }

  showmessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      'Game Over\n $message',
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 20),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tzc Tao'),
      ),
      body: Center(
        child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$occupied'),
              Text('$x'),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: MediaQuery.of(context).size.height / 2.6,
                  margin: const EdgeInsets.all(8),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            x = index;
                            occupied[index] = currentplayer;
                            changeplayer();
                            gamewinner();
                            gameended();
                          });
                        },
                        child: Container(
                          color: occupied[index].isEmpty
                              ? const Color.fromARGB(255, 90, 82, 82)
                              : occupied[index] == playerx
                                  ? Colors.orange
                                  : Colors.blue,
                          margin: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              occupied[index],
                              style: const TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      initialgame();
                    });
                  },
                  child: const Text('Restart'))
            ]),
      ),
    );
  }
}
