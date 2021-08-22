import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatefulWidget {
  @override
  _XylophoneAppState createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  bool state = false;
  bool _firstPress = true;
  AudioPlayer audioPlayer = AudioPlayer();
  int _backgroundImage = Random().nextInt(9);
  List<String> autoPlays = [
    "assets/autoplays/mysterious-xylophone_160bpm_E_minor.wav",
    "assets/autoplays/stoned-drip-xylophone_68bpm_C_minor.wav",
    "assets/autoplays/xylophone-attack_140bpm.wav",
    "assets/autoplays/melody.wav"
  ];

  void playSound(int _id) async {
    final player = AudioCache();
    player.play("note$_id.wav");
  }

  Expanded buildKey({required Color color, required int soundNumber}) {
    String text = "";
    return Expanded(
      child: MaterialButton(
        enableFeedback: false,
        color: color,
        onPressed: () {
          playSound(soundNumber);
        },
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/sakura$_backgroundImage.jpg"),
            fit: BoxFit.cover,
          )),
          child: SafeArea(
            child: Center(
              child: Opacity(
                opacity: 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                          enableFeedback: false,
                          color: Colors.red,
                          onPressed: () {
                            playSound(1);
                          },
                          child: Container(
                            alignment: Alignment.topRight,
                            height: 20,
                            child: FloatingActionButton(
                              onPressed: () {
                                changeBackground();
                              },
                              backgroundColor: Colors.red,
                              child: Icon(Icons.image),
                            ),
                          )),
                    ),
                    buildKey(color: Colors.orange, soundNumber: 2),
                    buildKey(color: Colors.yellow, soundNumber: 3),
                    buildKey(color: Colors.green, soundNumber: 4),
                    buildKey(color: Colors.blue, soundNumber: 5),
                    buildKey(color: Colors.indigo, soundNumber: 6),
                    Expanded(
                      child: MaterialButton(
                          enableFeedback: false,
                          color: Colors.purple,
                          onPressed: () {
                            playSound(7);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 30.0,
                                height: 30.0,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.play_arrow,
                                  ),
                                  onPressed: () async {
                                    if (_firstPress) {
                                      _firstPress = false;
                                      state = true;
                                      var randomItem =
                                          (autoPlays.toList()..shuffle()).first;
                                      if (state) {

                                        audioPlayer.play(randomItem,
                                            isLocal: true);
                                      }
                                    }
                                    debugPrint("Spam protection firstPress: " +
                                        _firstPress.toString());
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 30.0,
                                height: 30.0,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.stop,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      stopAuto();
                                      audioPlayer.stop();
                                    });
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changeBackground() {
    setState(() {
      int temp = Random().nextInt(9);
      while (temp == _backgroundImage) {
        temp = Random().nextInt(9);
      }
      _backgroundImage = temp;
    });
  }

  void stopAuto() {
    setState(() {
      state = false;
      _firstPress = true;
    });
  }
}
