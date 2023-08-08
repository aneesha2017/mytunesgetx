import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/dbfunctions.dart';
import 'package:music_app/models/favorite_model.dart';
import 'package:music_app/models/mostplayed_model.dart';
import 'package:music_app/models/playlist_model.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/screens/about.dart';
import 'package:music_app/screens/favorites.dart';
import 'package:music_app/screens/mostplayed.dart';
import 'package:music_app/screens/playlisthome.dart';
import 'package:music_app/screens/privacy.dart';
import 'package:music_app/screens/recent_songs.dart';
import 'package:music_app/screens/search_screen.dart';
import 'package:music_app/screens/splash_screen.dart';
import 'package:music_app/screens/terms.dart';
import 'package:music_app/widgets/bottom_nav.dart';
import 'package:get/get.dart';
import 'models/recent_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(SongsAdapter());
  }

  await Hive.openBox<Songs>('AllSongs');
  Hive.registerAdapter(FavouritesAdapter());
  openfavourite();
  Hive.registerAdapter(MostPlayedAdapter());
  openmostplayeddb();
  Hive.registerAdapter(RecentAdapter());
  openrecent();
  Hive.registerAdapter(PlaylistSongsAdapter());
  await Hive.openBox<PlaylistSongs>('playlist');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          // ignore: deprecated_member_use
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const Splashscreen(),
      initialRoute: '/bottomnav',
      getPages: [
        GetPage(name: '/bottomnav', page: () => BottomNavigation()),
        GetPage(name: '/search', page: () => SearchScreen()),
        GetPage(name: '/recent', page: () => const RecentSongs()),
        GetPage(name: '/favorite1', page: () => FavoritesScreen()),
        GetPage(name: '/playlist', page: () => Playgrid()),
        GetPage(name: '/mostplay', page: () => MostPlayedScreen()),
        GetPage(name: '/abouts', page: () => const AboutUs()),
        GetPage(name: '/privacy', page: () => const PrivacyPolicy()),
        GetPage(name: '/terms', page: () => const Terms()),
      ],
    );
  }
}
