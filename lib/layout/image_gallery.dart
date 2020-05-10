import 'package:flutter/material.dart';

import '../widget_util.dart';

class ImageGallery extends StatelessWidget {
  final List<String> imageList;

  ImageGallery({this.imageList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 144,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: imageList
                ?.map((e) => ImageGalleryItem(
                      url: e,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ImageGalleryItem extends StatelessWidget {
  final String url;

  ImageGalleryItem({this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 144,
      height: 144,
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: DefaultIconWidget(
                  icon: Icons.image,
                ),
              ),
              Positioned.fill(
                child: Image.network(
                  getImageUrl(url, resize: 'cover', size: 144) ?? '',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
