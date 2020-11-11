import 'package:flutter/material.dart';
import 'package:music_player/src/models/audio_player_model.dart';
import 'package:music_player/src/pages/music_player_page.dart';
import 'package:music_player/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AudioPlayerModel()),
    ],
    child: MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: miTema,
      home: MusicPlayerPage(),
    ),
  ));
}
