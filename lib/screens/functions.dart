import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/dbfunctions.dart';
import 'package:music_app/models/favorite_model.dart';
import 'package:music_app/models/mostplayed_model.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/playlist_model.dart';
import '../models/recent_model.dart';
import '../widgets/home_screen_song_tile.dart';

addRecently(Recent value) {
  List<Recent> list = recentdb.values.toList();
  bool isNot =
      list.where((element) => element.songname == value.songname).isEmpty;
  if (isNot == true) {
    recentdb.add(value);
  } else {
    int index =
        list.indexWhere((element) => element.songname == value.songname);
    recentdb.deleteAt(index);
    //recentdb.delete(value);
    recentdb.add(value);
  }
  log('added recent now');
}

addMostplayed(int index, MostPlayed value) async {
  //final box = MostplayedBox.getInstance();
  log('entered?????????');
  final box = SongBox.getInstance();
  List<Songs> allsongs = box.values.toList();
  List<MostPlayed> list = mostplayeddb.values.toList();
  log(index.toString());
  bool isNot =
      list.where((element) => element.id == allsongs[index].id).isEmpty;
  log(isNot.toString());
  if (isNot == true) {
    await mostplayeddb.add(value);
    log('added');
    log(mostplayeddb.values.toList().toString());
  } else {
    int indexMostly = list.indexWhere((element) => element.id == value.id);
    log(indexMostly.toString());
    log(list[indexMostly].count.toString());
    int count = list[indexMostly].count;
    value.count = count + 1;
    //await mostplayeddb.deleteAt(index);
    await mostplayeddb.putAt(indexMostly, value);
    log('modified');
    log(mostplayeddb.values.toList().toString());
    log(list[indexMostly].count.toString());
  }
}

//////////////////////////////////
newplaylist(String title) {
  final playlistbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs> dbplaylist = playlistbox.values.toList();
  bool isAlready =
      dbplaylist.where((element) => element.playlistname == title).isEmpty;
  if (isAlready) {
    List<Songs> playlistsongs = [];
    playlistbox
        .add(PlaylistSongs(playlistname: title, playlistsong: playlistsongs));
  }
}

addtoplaylist(Songs song, int index) {
  final playlistbox = PlaylistSongsbox.getInstance();
  List<PlaylistSongs> dbplayllist = playlistbox.values.toList();
  print(dbplayllist);
}

deleteplaylist(int index) {
  final playlistbox = PlaylistSongsbox.getInstance();
  playlistbox.deleteAt(index);
}

deletefromplaylist(int index) {
  final playlistbox = PlaylistSongsbox.getInstance();
  playlistbox.delete(index);
  log('song deleted');
  log(playlistbox.values.toString());
}
