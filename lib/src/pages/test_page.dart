import 'package:flutter/material.dart';
import 'package:youtube_player/youtube_player.dart';

class TestPage extends StatefulWidget {
  TestPage({Key key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String id = "t433PEQGErc";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('holasss'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              YoutubePlayer(
                context: context,
                source: id,
                quality: YoutubeQuality.HD,
              ),
              /*  RaisedButton(
                onPressed: () {
                  setState(() {
                    id = _idController.text;
                  });
                },
                child: Text("Play"),
              ), */
            ],
          ),
        ));
  }
}
