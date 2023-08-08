import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/screens/mini_player.dart';
import 'package:music_app/widgets/show_playlist_options.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/favoritecontroller.dart';
import '../models/mostplayed_model.dart';
import '../models/songs_model.dart';
import '../screens/functions.dart';

class FavouriteSongTile extends StatelessWidget {
  FavouriteSongTile({
    super.key,
  });

  final box = SongBox.getInstance();
  late List<Songs> allDbSongs = [];

  FavoriteController favcontroller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: favcontroller.likesongs.length,
      itemBuilder: (context, index) {
        final currentSong = favcontroller.likesongs[index];
        log(favcontroller.likesongs.toString());
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
                MostPlayed mostly = MostPlayed(
                  songname: favcontroller.likesongs[index].songname!,
                  songurl: favcontroller.likesongs[index].songurl!,
                  artist: favcontroller.likesongs[index].artist!,
                  count: 1,
                  id: favcontroller.likesongs[index].id!,
                );
                int indexMostly = allDbSongs.indexWhere((element) =>
                    element.songname ==
                    favcontroller.likesongs[index].songname);
                addMostplayed(indexMostly, mostly);
                player.open(
                  Playlist(
                      audios: favcontroller.convertedaudio, startIndex: index),
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
                id: currentSong.id!,
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
                currentSong.songname!,
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
