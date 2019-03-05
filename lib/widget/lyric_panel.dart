import 'package:flutter/material.dart';
import 'package:flutter_netease_music/model/lyric.dart';

typedef void PositionChangeHandler(int second);

class LyricPanel extends StatefulWidget {
  final Lyric lyric;
  PositionChangeHandler handler;

  LyricPanel(@required this.lyric);

  @override
  State<StatefulWidget> createState() {
    return new LyricState();
  }
}

class LyricState extends State<LyricPanel> {
  int index = 0;
  LyricSlice currentSlice;

  @override
  void initState() {
    super.initState();
    widget
      ..handler = ((position) {
        print("..handler" + position.toString());
        LyricSlice slice = widget.lyric.slices[index];
        if (position > slice.in_second) {
          index++;
          setState(() {
            currentSlice = slice;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            currentSlice != null ? currentSlice.slice : "",
            style: new TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildLyricItems(Lyric lyric) {
    List<Widget> items = new List();
    for (LyricSlice slice in lyric.slices) {
      if (slice != null && slice.slice != null) {
        items.add(new Center(
          child: new Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              slice.slice,
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ));
      }
    }
    return items;
  }
}
