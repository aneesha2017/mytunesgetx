import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/controllers/homecontroller.dart';
import 'package:music_app/dbfunctions.dart';
import 'package:music_app/models/mostplayed_model.dart';
import 'package:music_app/models/recent_model.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/functions.dart';
import 'package:music_app/screens/mini_player.dart';
import 'package:music_app/screens/nowplaying.dart';
import 'package:music_app/widgets/show_playlist_options.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/favoritecontroller.dart';
import '../models/playlist_model.dart';

class Homescreensongtile extends StatelessWidget {
  Homescreensongtile({
    super.key,
  });

//final mostbox = MostplayedBox.getInstance();

  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  final List<MostPlayed> mostplayed = mostplayeddb.values.toList();

  final box = SongBox.getInstance();
  //late List<Songs> songDatabase;
  List<Audio> audios = [];
  //Recent? recentsong;
  Homecontroller homecontroller = Get.put(Homecontroller());
  FavoriteController favcontroller = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    List<Songs> songlistDb = box.values.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        //itemCount: songlistDb.length,
        itemCount: homecontroller.homegets.length,
        itemBuilder: (context, index) {
          final currentSong = homecontroller.homegets[index];
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
                    songname: currentSong.songname!,
                    songurl: currentSong.songurl!,
                    artist: currentSong.artist!,
                    count: 1,
                    id: currentSong.id!,
                  );
                  log('adding to mostly>>>>>>>>.before');
                  log(index.toString());
                  log(mostly.toString());
                  addMostplayed(index, mostly);
                  log('added to mostly>>>>>>>>.after');

                  Recent recent = Recent(
                    id: currentSong.id,
                    artist: currentSong.artist,
                    songname: currentSong.songname,
                    songurl: currentSong.songurl,
                  );
                  addRecently(recent);
                  // Recent rently = Recent(
                  //   songname: songlistDb[index].songname!,
                  //   songurl: songlistDb[index].songurl!,
                  //   artist: songlistDb[index].artist!,
                  //   id: songlistDb[index].id!,
                  // );
                  // log('adding to recent');
                  // log(index.toString());
                  // log(rently.toString());
                  // addRecently(index, rently);
                  // log('added to recently>>>>>>>>.after');

                  player.open(
                    Playlist(
                        audios: homecontroller.convertedsongs,
                        startIndex: index),
                    headPhoneStrategy:
                        HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
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
      ),
    );
  }
}
