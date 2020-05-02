import 'package:flutter/material.dart';

class ImageGallery extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 200,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 200,
                color: Colors.red,
              ),
              Container(
                height: 200,
                color: Colors.green,
              ),
              Container(
                height: 200,
                color: Colors.yellow,
              ),
              Container(
                height: 200,
                color: Colors.blue,
              ),
              Container(
                height: 200,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageGalleryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: AspectRatio(
        aspectRatio: 1,
        child: FadeInImage(
          image: NetworkImage(
              'https://p2.music.126.net/3VCqOJSYLEAiCtodKgxrXg==/2528876744253082.jpg?param=946y946'),
          placeholder: AssetImage('images/default_album.jpg'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
