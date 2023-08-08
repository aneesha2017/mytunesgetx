import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controllers/favoritecontroller.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../const/colors.dart';

class Search_song_tile extends StatelessWidget {
  int index;
  List<Songs> searchnew;
  List<Audio> convertedaudio;
  Search_song_tile(
      {super.key,
      required this.index,
      required this.searchnew,
      required this.convertedaudio});
  FavoriteController favcontroller = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
    return GestureDetector(
      onTap: () {
        player.open(
          Playlist(audios: convertedaudio, startIndex: index),
          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
          showNotification: true,
        );
        log('before bottom sheet');
        showBottomSheet(
          context: context,
          builder: (context) => Miniplayer(
            index: index,
          ),
        );
        log('after bottom sheet');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                topRight: Radius.circular(50)),
          ),
          height: 80,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QueryArtworkWidget(
                  id: searchnew[index].id!,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'lib/assets/images.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      searchnew[index].songname!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        player.play();
                      },
                      icon: const Icon(Icons.play_circle_filled),
                    ),
                    Obx(
                      () => IconButton(
                        onPressed: (favcontroller.checkFavorite(index))
                            ? () {
                                log('fav clicked>>>>>');
                                log(favcontroller
                                    .checkFavorite(index)
                                    .toString());
                                favcontroller.removeFavour(index);
                              }
                            : () {
                                favcontroller.addfavour(index);
                                log('fav clicked>>>>>');
                              },
                        icon: Icon(
                          (favcontroller.checkFavorite(index))
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: mywhite,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.library_add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
