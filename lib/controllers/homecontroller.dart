import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:music_app/models/songs_model.dart';

class Homecontroller extends GetxController {
  var homegets = <Songs>[].obs;
  var convertedsongs = <Audio>[].obs;
  final box = SongBox.getInstance();

  @override
  void onInit() {
    fetchsongs();
    super.onInit();
  }

  void fetchsongs() {
    homegets.value = box.values.toList();

    for (var i in homegets) {
      convertedsongs.add(
        Audio.file(
          i.songurl!,
          metas: Metas(
            title: i.songname,
            id: i.id.toString(),
          ),
        ),
      );
    }
  }
}
