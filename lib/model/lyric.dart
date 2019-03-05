class Lyric {
  List<LyricSlice> slices;

  Lyric(this.slices);
}

class LyricSlice {
  int in_second; //歌词片段开始时间
  String slice; //片段内容

  Lyric(int in_second, String slice) {
    this.in_second = in_second;
    this.slice = slice;
  }
}
