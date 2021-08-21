import 'dart:io';
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
  bool status = false;

  bool state = false;

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
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildKey(color: Colors.red, soundNumber: 1),
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
                              onPressed: () {
                                state = true;
                                setState(() async {
                                  while (state) {
                                    int delay = Random().nextInt(500) + 100;
                                    playSound(Random().nextInt(7) + 1);
                                    await Future.delayed(
                                        Duration(milliseconds: delay));
                                  }
                                });
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
                                setState(() async {
                                  state = false;
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
    );
  }
}
