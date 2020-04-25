import 'package:flutter/material.dart';

import '../model/song.dart';

abstract class SongDetailHeader extends StatelessWidget {
  final Song song;
  SongDetailHeader({this.song});
}