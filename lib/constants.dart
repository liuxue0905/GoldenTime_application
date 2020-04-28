import 'package:flutter/material.dart';

class Constants {
  // #f6f6f5 (246, 246, 245)
  // #e1e3e3 (225, 227, 227)
  static const List<Color> backgroundColorList = [
    Color.fromRGBO(250, 250, 250, 1.0),
    Color(0xff1ee8b6),
    Color(0xff4b2460),
    Color(0xff5dced6),
    Color(0xff19ba6a),
    Color(0xff47c7fe),
    Color(0xff531e65),
    Color(0xff4413ba),
    Color(0xff17316d),
    Color(0xff54215f),
    Color(0xff63230a),
    Color(0xff392291),
    Color(0xff512257),
    Color(0xff532164),
    Color(0xffbfb2ff),
    Color(0xffc6fbe5),
    Color(0xff4bceff),
    Color(0xff12b969),
  ];

  static const List<String> backgroundImagesList = [
    '',
    'images/background_image/1ee8b6.png',
    'images/background_image/4b2460.png',
    'images/background_image/5dced6.png',
    'images/background_image/19ba6a.png',
    'images/background_image/47c7fe.png',
    'images/background_image/531e65.png',
    'images/background_image/4413ba.png',
    'images/background_image/17316d.png',
    'images/background_image/54215f.png',
    'images/background_image/63230a.png',
    'images/background_image/392291.png',
    'images/background_image/512257.png',
    'images/background_image/532164.png',
    'images/background_image/bfb2ff.png',
    'images/background_image/c6fbe5.png',
    'images/background_image/4bceff.png',
    'images/background_image/12b969.png',
  ];

  // backgroundImage    backgroundColor           separatorColor
  // colored_now_card   #000000 (0,0,0,1)         #ffffff (255,255,255,1)
  // image              #161110 (22,17,16,1)      #6dc583 (109,197,131,1)
  // 1ee8b6.png         #1ee8b6
  // 4b2460.png         #4b2460                   #48eadc (72,234,220,1)
  // 5dced6.png         #5dced6                   #f9b339 (249,179,57,1)
  // 19ba6a.png         #19ba6a
  // 47c7fe.png         #47c7fe
  // 531e65.png         #531e65                   #fbc737 (251,199,55,1)
  // 4413ba.png         #4413ba                   #e05252 (224,82,82,1)
  // 17316d.png         #17316d
  // 54215f.png         #54215f                   #eb8fed (235,143,237,1)
  // 63230a.png         #63230a                   #f9f26a (249,242,106,1)
  // 392291.png         #392291
  // 512257.png         #512257
  // 532164.png         #532164                   #f8ffb8 (248,255,184,1)
  // bfb2ff.png         #bfb2ff                   #f8ffb8 (255,245,118,1)
  // c6fbe5.png         #c6fbe5                   #ff3347 (255,51,71,1) #f8ffb8
  // 4bceff.png         #4bceff
  // 12b969.png         #12b969

  Map<String, Color> backgroundImageColorMap = {
    null: Color.fromRGBO(250, 250, 250, 1.0),
    '': Color.fromRGBO(250, 250, 250, 1.0),
    'images/background_image/1ee8b6.png': Color(0xff1ee8b6),
    'images/background_image/4b2460.png': Color(0xff4b2460),
    'images/background_image/5dced6.png': Color(0xff5dced6),
    'images/background_image/19ba6a.png': Color(0xff19ba6a),
    'images/background_image/47c7fe.png': Color(0xff47c7fe),
    'images/background_image/531e65.png': Color(0xff531e65),
    'images/background_image/4413ba.png': Color(0xff4413ba),
    'images/background_image/17316d.png': Color(0xff17316d),
    'images/background_image/54215f.png': Color(0xff54215f),
    'images/background_image/63230a.png': Color(0xff63230a),
    'images/background_image/392291.png': Color(0xff392291),
    'images/background_image/512257.png': Color(0xff512257),
    'images/background_image/532164.png': Color(0xff532164),
    'images/background_image/bfb2ff.png': Color(0xffbfb2ff),
    'images/background_image/c6fbe5.png': Color(0xffc6fbe5),
    'images/background_image/4bceff.png': Color(0xff4bceff),
    'images/background_image/12b969.png': Color(0xff12b969),
  };
}
