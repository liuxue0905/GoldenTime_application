import 'package:flutter/material.dart';

import 'models.dart';
import 'routes.dart';

// backgroundImage    backgroundColor           separatorColor
// colored_now_card   #000000 (0,0,0,1)         #ffffff (255,255,255,1) 默认背景
// image              #161110 (22,17,16,1)      #6dc583 (109,197,131,1) 照片图片
// '' null            background-color: rgb(250, 250, 250);
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
// bfb2ff.png         #bfb2ff                   #f8ffb8 (255,245,118,1) #fff576
// c6fbe5.png         #c6fbe5                   #ff3347 (255,51,71,1) #f8ffb8
// 4bceff.png         #4bceff
// 12b969.png         #12b969

const List<GPMQuickNavItem> kGPMQuickNavItems = [
  GPMQuickNavItem(
      icon: Icons.home,
      text: '首页',
      routeName: RouteConfiguration.routeNameHome),
  GPMQuickNavItem(
      icon: Icons.album,
      text: '唱片',
      routeName: RouteConfiguration.routeNameRecordList),
  GPMQuickNavItem(
      icon: Icons.account_box,
      text: '歌手',
      routeName: RouteConfiguration.routeNameArtistList),
  GPMQuickNavItem(
      icon: Icons.library_music,
      text: '歌曲',
      routeName: RouteConfiguration.routeNameSongList),
  GPMQuickNavItem(
      icon: Icons.home,
      text: '测试',
      routeName: RouteConfiguration.routeNameTest),
];
