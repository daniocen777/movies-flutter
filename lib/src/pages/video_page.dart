import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/video_model.dart';
import 'package:youtube_player/youtube_player.dart';

class VideoPage extends StatefulWidget {
  VideoPage({Key key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    final Video video = ModalRoute.of(context).settings.arguments;
    String id = video.key;
    return Scaffold(
        appBar: AppBar(
          title: Text(video.name, style: TextStyle(fontSize: 12.0),),
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
