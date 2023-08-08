import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controllers/favoritecontroller.dart';
import 'package:music_app/controllers/mostplaycontroller.dart';
import 'package:music_app/screens/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../const/colors.dart';
import '../widgets/show_playlist_options.dart';

class Most_song_tile extends StatelessWidget {
  Most_song_tile({
    super.key,
  });

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  FavoriteController favcontroller = Get.put(FavoriteController());
  MostplayController mostcontroller = Get.put(MostplayController());

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mostcontroller.mostplayed.length,
      itemBuilder: (context, index) {
        log(index.toString());
        final currentSong = mostcontroller.mostplayed[index];
        int indexMostly = mostcontroller.dballsongs
            .indexWhere((element) => element.id == currentSong.id);
        log(mostcontroller.mostplayed.toString());
        log(indexMostly.toString());
        return Container(
          height: 75,
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                topRight: Radius.circular(50)),
          ),
          child: Center(
            child: ListTile(
              onTap: () {
                audioPlayer.open(
                  Playlist(
                      audios: mostcontroller.convertedsongs, startIndex: index),
                  headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                  showNotification: true,
                );
                showBottomSheet(
                  context: context,
                  builder: (context) => Miniplayer(
                    index: index,
                  ),
                );
              },
              leading: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(10),
                id: currentSong.id,
                type: ArtworkType.AUDIO,
                artworkQuality: FilterQuality.high,
                quality: 100,
                size: 2000,
                artworkFit: BoxFit.fill,
                nullArtworkWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'lib/assets/images.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                currentSong.songname,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    Obx(
                      () => IconButton(
                        onPressed: (favcontroller.checkFavorite(index))
                            ? () {
                                // if (favcontroller.checkFavorite(index)) {
                                log('fav clicked>>>>>');
                                log(favcontroller
                                    .checkFavorite(index)
                                    .toString());
                                favcontroller.removeFavour(index);
                                // } else {

                                //}
                                //log('pressed remove?????/');
                                //removeFavour(index);
                                //  setState(() {});
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
                        onPressed: () {
                          showPlaylistOptions(context, index);
                        },
                        icon: const Icon(Icons.library_add)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 15,
        );
      },
    );
  }
}
