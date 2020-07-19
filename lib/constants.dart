import 'package:flutter/material.dart';
import 'package:flutter_app_golden_time/artist/artists.dart';
import 'package:flutter_app_golden_time/home2/home2.dart';
import 'package:flutter_app_golden_time/recrod/records.dart';
import 'package:flutter_app_golden_time/song/songs.dart';

import 'home/home.dart';
import 'models.dart';

const List<GPMQuickNavItem> kGPMQuickNavItems = [
  GPMQuickNavItem(
    icon: Icons.home,
    text: '首页',
    routeName: Home2Page.routeName,
  ),
  GPMQuickNavItem(
    icon: Icons.album,
    text: '唱片',
    routeName: RecordsPage.routeName,
  ),
  GPMQuickNavItem(
    icon: Icons.account_box,
    text: '歌手',
    routeName: ArtistsPage.routeName,
  ),
  GPMQuickNavItem(
    icon: Icons.library_music,
    text: '歌曲',
    routeName: SongsPage.routeName,
  ),
  GPMQuickNavItem(
    icon: Icons.home,
    text: '测试',
    routeName: HomePage.routeName,
  ),
];
