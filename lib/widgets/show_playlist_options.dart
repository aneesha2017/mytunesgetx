import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/models/songs_model.dart';

import '../const/colors.dart';
import '../models/playlist_model.dart';

showPlaylistOptions(BuildContext context, int songindex) {
  final box = PlaylistSongsbox.getInstance();
  final songbox = SongBox.getInstance();
  double vwidth = MediaQuery.of(context).size.width;
  showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: mybackgroundColor,
              alignment: Alignment.bottomCenter,
              content: SizedBox(
                height: 200,
                width: vwidth,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder<Box<PlaylistSongs>>(
                            valueListenable: box.listenable(),
                            builder: (context, Box<PlaylistSongs> playlistSong,
                                child) {
                              List<PlaylistSongs> playlistsong =
                                  playlistSong.values.toList();
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: playlistsong.length,
                                  itemBuilder: ((context, index) {
                                    return ListTile(
                                      onTap: () {
                                        PlaylistSongs? playlsong =
                                            playlistSong.getAt(index);
                                        List<Songs> playsongdb =
                                            playlsong!.playlistsong!;
                                        List<Songs> songdb =
                                            songbox.values.toList();
                                        bool isAlreadyAdded = playsongdb.any(
                                            (element) =>
                                                element.id ==
                                                songdb[songindex].id);
                                        if (!isAlreadyAdded) {
                                          playsongdb.add(
                                            Songs(
                                              songname:
                                                  songdb[songindex].songname,
                                              artist: songdb[songindex].artist,
                                              songurl:
                                                  songdb[songindex].songurl,
                                              id: songdb[songindex].id,
                                            ),
                                          );
                                        }
                                        playlistSong.putAt(
                                            index,
                                            PlaylistSongs(
                                                playlistname:
                                                    playlistsong[index]
                                                        .playlistname,
                                                playlistsong: playsongdb));
                                        print(
                                            'song added to${playlistsong[index].playlistname}');
                                        Navigator.pop(context);
                                      },
                                      title: Text(
                                        playlistsong[index].playlistname!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }));
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          }));
}
