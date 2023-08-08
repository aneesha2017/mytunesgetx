import 'package:flutter/material.dart';
import 'package:music_app/screens/functions.dart';

import '../const/colors.dart';

showplaylistOptionsadd(BuildContext context) {
  final myController = TextEditingController();
  double vwidth = MediaQuery.of(context).size.width;
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: mywhite,
            alignment: Alignment.bottomCenter,
            content: Container(
              height: 250,
              width: vwidth,
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text(
                        'New Playlist',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 250, 249, 249)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: vwidth * 0.90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: myController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white10,
                              label: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Enter Playlist Name:',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              // alignLabelWithHint: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: vwidth * 0.43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                          ),
                          child: TextButton.icon(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: const Text('Cancel',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: vwidth * 0.43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: TextButton.icon(
                            icon: const Icon(
                              Icons.done,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              newplaylist(myController.text);
                              Navigator.pop(context);
                            },
                            label: const Text(
                              'Done',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
}
