import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/screens/playlisthome.dart';
import '../models/songs_model.dart';
import '../widgets/home_screen_song_tile.dart';
import 'homescreen/widget/horizontal_home_scrolling.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  //final box = SongBox.getInstance();

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Get.toNamed('favorite1'),
                        child: Newcontainer(
                            folder: 'Favorites',
                            image: 'lib/assets/Untitled design (1).png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () => Get.toNamed('recent'),
                        child: Newcontainer(
                          folder: 'Recent Songs',
                          image: 'lib/assets/Untitled design (2).png',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () => Get.to(() => Playgrid()),
                        child: Newcontainer(
                            folder: 'Playlist',
                            image: 'lib/assets/Untitled design (1).png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () => Get.toNamed('mostplay'),
                        child: Newcontainer(
                            folder: 'mostplayed',
                            image: 'lib/assets/Untitled design.png'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Homescreensongtile(),
        ],
      ),
    );
  }
}
