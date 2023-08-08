import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/controllers/favoritecontroller.dart';
import 'package:music_app/models/favorite_model.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';
import 'package:music_app/widgets/favorite_song_tile.dart';
import '../dbfunctions.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  // List<Favourites> likedsongs = [];

  // final box = SongBox.getInstance();

  // late List<Songs> allDbSongs = [];

  // List<Audio> Favsongs = [];
  FavoriteController favcontroller = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    //AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
    favcontroller.likesongs;
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Myappbar(title: 'Favorites', trailing: const SizedBox()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: FavouriteSongTile(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
