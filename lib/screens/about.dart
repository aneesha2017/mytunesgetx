import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/screens/common%20widget/myappbar.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mybackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Myappbar(title: 'About Us', trailing: const SizedBox()),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: about(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget about() {
  return const Text(
    '''
About Us : 

We are a team of passionate music lovers who have come together to create a better music listening experience for you. Our app is designed to make it easy for you to discover new music, create personalized playlists, and enjoy your favorite tracks anytime, anywhere.

We believe in the power of music to bring people together, and we strive to create a welcoming and inclusive community for music fans of all kinds. We are constantly working to improve the app and add new features to enhance your listening experience.

Thank you for choosing [app name] as your go-to music player. We hope you enjoy using it as much as we enjoyed creating it. If you have any feedback or suggestions, we would love to hear from you. Contact us at [contact information].

''',
    style: TextStyle(letterSpacing: 5, color: Colors.white, fontSize: 15),
  );
}
