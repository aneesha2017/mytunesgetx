import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music_app/models/songs_model.dart';

class SearchController extends GetxController {
  var searchsongsnew = <Songs>[].obs;
  var convertedsongs = <Audio>[].obs;
  var dbAllsongs = <Songs>[].obs;
  final box = SongBox.getInstance();

  @override
  void onInit() {
    fetchSongs();
    super.onInit();
  }

  void fetchSongs() {
    dbAllsongs.value = box.values.toList();
    searchsongsnew.value = List.from(dbAllsongs);
    for (var element in searchsongsnew) {
      convertedsongs.add(Audio.file(element.songurl.toString(),
          metas: Metas(
              artist: element.artist,
              title: element.songname,
              id: element.id.toString())));
    }
  }

  void filteringSongs(String text) {
    log('<<<<<<<<<on chang>>>>>>>>>');
    if (text.isEmpty) {
      log('<<<if>>>');
      // If search text is empty, display all songs
      searchsongsnew.value = List.from(dbAllsongs);
    } else {
      // Filter songs based on search text
      log('<<<<<<<else>>>>>>>');
      log(text);
      searchsongsnew.value = dbAllsongs
          .where((element) =>
              element.songname!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    log(searchsongsnew.toString());
    convertedsongs.clear();
    for (var element in searchsongsnew) {
      convertedsongs.add(Audio.file(element.songurl.toString(),
          metas: Metas(
              artist: element.artist,
              title: element.songname,
              id: element.id.toString())));
    }
  }
}
