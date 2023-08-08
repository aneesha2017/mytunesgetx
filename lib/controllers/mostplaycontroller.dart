import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music_app/models/mostplayed_model.dart';
import '../dbfunctions.dart';
import '../models/songs_model.dart';

class MostplayController extends GetxController {
  final box = SongBox.getInstance();
  List<Songs> dballsongs = [];
  var convertedsongs = <Audio>[].obs;
  var mostplayed = <MostPlayed>[].obs;
  var dbAllsongs = <Songs>[].obs;

  @override
  void onInit() {
    mostplay();
    super.onInit();
  }

  @override
  void mostplay() {
    List<MostPlayed> mostsong = mostplayeddb.values.toList();
    int i = 0;
    for (var element in mostsong) {
      if (element.count > 3) {
        mostplayed.insert(i, element);
        i++;
      }
    }
    for (var items in mostplayed) {
      convertedsongs.add(Audio.file(items.songurl,
          metas: Metas(
              title: items.songname,
              artist: items.artist,
              id: items.id.toString())));
    }
  }
}
