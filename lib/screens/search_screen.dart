import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/widgets/search_song_tile.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../controllers/searchcontroller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  // List<Songs> dbAllSongs = [];
  // List<Songs> searchNew = [];
  // List<Audio> convertedaudio = [];
  // final box = SongBox.getInstance();

  //late String searchText;
  final TextEditingController search = TextEditingController();
  SearchController searchcontroller = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchBarAnimation(
              textEditingController: search,
              isOriginalAnimation: true,
              trailingWidget: const Icon(Icons.search),
              secondaryButtonWidget: IconButton(
                  onPressed: () {
                    search.clear();
                    //searchNew = List.from(dbAllSongs);
                    //  setState(() {});
                  },
                  icon: Icon(Icons.clear)),
              buttonWidget: const Icon(Icons.search),
              buttonColour: Colors.orange,
              buttonShadowColour: Colors.red,
              durationInMilliSeconds: 1000,
              onChanged: (val) {
                searchcontroller.filteringSongs(val);
                //setState(() {});
              },
            ),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => Search_song_tile(
                  index: index,
                  searchnew: searchcontroller.searchsongsnew,
                  convertedaudio: searchcontroller.convertedsongs,
                ),
                itemCount: searchcontroller.searchsongsnew.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
