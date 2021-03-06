import 'package:flutter/material.dart';
import 'package:musicplayer/src/pages/music_player_page.dart';
import 'package:musicplayer/src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: miTema,
      debugShowCheckedModeBanner: false,
      home: MusicPlayerPage(),
    );
  }
}
