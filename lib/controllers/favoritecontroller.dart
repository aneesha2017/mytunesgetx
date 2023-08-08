import 'dart:developer';
import 'dart:ffi';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music_app/dbfunctions.dart';
import 'package:music_app/models/songs_model.dart';

import '../models/favorite_model.dart';

class FavoriteController extends GetxController {
  var likesongs = <Favourites>[].obs;
  var convertedaudio = <Audio>[].obs;
  final box = SongBox.getInstance();

  @override
  void onInit() {
    favosongs();
    super.onInit();
  }

  void favosongs() {
    likesongs.value = favouritedb.values.toList().reversed.toList();
    log(likesongs.toString());
    for (var element in likesongs) {
      convertedaudio.add(Audio.file(element.songurl.toString(),
          metas: Metas(
            artist: element.artist,
            title: element.songname,
            id: element.id.toString(),
          )));
      log(element.songname!);
    }
  }

  void addfavour(int index) async {
    final box = SongBox.getInstance();
    List<Songs> dballsongs = box.values.toList();
    //List<Favourites> likedsongs = favouritedb.values.toList();
    await favouritedb.add(Favourites(
        id: dballsongs[index].id,
        songname: dballsongs[index].songname,
        artist: dballsongs[index].artist,
        songurl: dballsongs[index].songurl));
    //log(likedsongs[index].songname!);
    favosongs();
  }

  removeFavour(int index) async {
    log('<<<<<<<<<<<remove>>>>>>>>>>>');
    final box = SongBox.getInstance();
    List<Songs> allsongs = box.values.toList();
    //final box2 = FavouriteBox.getInstance();
    List<Favourites> favorite = favouritedb.values.toList();
    //List<Songs> songs = box.values.toList();

    int currentindex =
        likesongs.indexWhere((element) => element.id == allsongs[index].id);
    int dbIndex =
        favorite.indexWhere((element) => element.id == allsongs[index].id);
    log(index.toString());
    log(',,,,,,,,,');
    log(currentindex.toString());
    log(dbIndex.toString());
    log('<<<<<,,id checking>>>>>');
    log(likesongs[currentindex].id.toString());
    log(favorite[dbIndex].id.toString());
    likesongs.removeAt(currentindex);
    await favouritedb.deleteAt(dbIndex);
    log(favouritedb.values.toList().toString());
    favosongs();
  }

  bool checkFavorite(int index) {
    log('<<<<<<<<<check>>>>>>>>>');
    final box = SongBox.getInstance();
    List<Songs> allsongs = box.values.toList();
    //List<Favourites> favoritesongs = favouritedb.values.toList();
    bool isalready =
        likesongs.any((element) => element.id == allsongs[index].id);
    log(isalready.toString());
    return isalready;
  }
}
