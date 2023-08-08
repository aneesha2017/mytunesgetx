import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/screens/most_song_tile.dart';

class MostPlayedScreen extends StatelessWidget {
  MostPlayedScreen({super.key});

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  //List<Audio> songs = [];
  // List<MostPlayed> mostplayedsongs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Myappbar(title: 'Most Played', trailing: const SizedBox()),
            SizedBox(
              child: Most_song_tile(),
            )
          ],
        ),
      ),
    );
  }
}
