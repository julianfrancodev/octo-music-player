import 'package:flutter/material.dart';
import 'package:music_player/src/pages/music_player_page.dart';
import 'package:music_player/src/theme/theme.dart';

void main(){
  runApp(
    MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: miTema,
      home: MusicPlayerPage(),
    )
  );
}