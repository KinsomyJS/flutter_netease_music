import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_netease_music/anims/needle_anim.dart';
import 'package:flutter_netease_music/anims/record_anim.dart';
import 'package:flutter_netease_music/player_page.dart';

void main() => runApp(new MyApp());

final GlobalKey<MusicPlayerState> musicPlayerKey = new GlobalKey();

const String coverArt =
        'https://images.rapgenius.com/4xo4vvlzcnbsluagktti85tf1.1000x1000x1.jpg',
    mp3Url = 'https://ia801000.us.archive.org/22/items/MagnaCarta/13.Bbc.mp3';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MusicPlayerExample(),
    );
  }
}

class MusicPlayerExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MusicPlayerExampleState();
  }
}

class _MusicPlayerExampleState extends State<MusicPlayerExample>
    with TickerProviderStateMixin {
  MusicPlayerLoopKind loopKind;
  bool shuffle = false;
  AnimationController controller_record;
  Animation<double> animation_record;
  Animation<double> animation_needle;
  AnimationController controller_needle;
  final _rotateTween = new Tween<double>(begin: -0.15, end: 0.0);
  final _commonTween = new Tween<double>(begin: 0.0, end: 1.0);
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    controller_record = new AnimationController(
        duration: const Duration(milliseconds: 15000), vsync: this);
    animation_record =
        new CurvedAnimation(parent: controller_record, curve: Curves.linear);

    controller_needle = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation_needle =
        new CurvedAnimation(parent: controller_needle, curve: Curves.linear);

    animation_record.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller_record.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller_record.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new NetworkImage(coverArt),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                Colors.black54,
                BlendMode.overlay,
              ),
            ),
          ),
        ),
        new Container(
            child: new ClipRect(
                child: new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Opacity(
            opacity: 0.1,
            child: new Container(
              decoration: new BoxDecoration(
//                  color: Colors.grey.shade200.withOpacity(0.5),
                color: Colors.grey.shade100,
              ),
            ),
          ),
        ))),
        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'NOW PLAYING',
                  textScaleFactor: 0.60,
                ),
                const Text(
                  'JAY Z - Holy Grail',
                  textScaleFactor: 0.75,
                ),
              ],
            ),
          ),
          body: new Stack(
            alignment: const FractionalOffset(0.5, 0.0),
            children: <Widget>[
              new Stack(
                alignment: const FractionalOffset(0.7, 0.1),
                children: <Widget>[
                  new Container(
                    child: RotateRecord(
                        animation: _commonTween.animate(controller_record)),
                    margin: EdgeInsets.only(top: 100.0),
                  ),
                  new Container(
                    child: new PivotTransition(
                      turns: _rotateTween.animate(controller_needle),
                      alignment: FractionalOffset.topLeft,
                      child: new Container(
                        width: 100.0,
                        child: new Image.asset("images/play_needle.png"),
                      ),
                    ),
                  ),
                ],
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: new MusicPlayer(
                  onError: (e) {
                    Scaffold.of(context).showSnackBar(
                      new SnackBar(
                        content: new Text(e),
                      ),
                    );
                  },
                  onSkipPrevious: () {},
                  onSkipNext: () {},
                  onCompleted: () {},
                  onPlaying: (isPlaying) {
                    if (isPlaying) {
                      controller_record.forward();
                      controller_needle.forward();
                    } else {
                      controller_record.stop(canceled: false);
                      controller_needle.reverse();
                    }
                  },
                  onLoopChanged: (loop) {
                    setState(() => this.loopKind = loop);
                  },
                  onShuffleChanged: (loop) {
                    setState(() => this.shuffle = loop);
                  },
                  key: musicPlayerKey,
                  textColor: Colors.white,
                  loop: loopKind,
                  shuffle: shuffle,
                  url: mp3Url,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller_record.dispose();
    controller_needle.dispose();
    super.dispose();
  }
}
