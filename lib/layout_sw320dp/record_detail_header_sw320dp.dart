import 'package:flutter/material.dart';

import '../layout/artist_bar.dart';
import '../layout_swNdp/record_detail_header_swndp.dart';
import '../model/record.dart';
import '../util.dart';

class Sw320dpRecordDetailHeaderContainer
    extends SwNdpRecordDetailHeaderContainer {
  final String url;
  final String title;
  final String subtitle;

  Sw320dpRecordDetailHeaderContainer({
    Key key,
    this.url,
    this.title,
    this.subtitle,
    Record record,
  }) : super(record: record);

//  factory Sw320dpRecordDetailHeaderContainer.forDesignTime() {
//    // TODO: add arguments
//    return new Sw320dpRecordDetailHeaderContainer(
//      url: "https://www.baidu.com/img/bd_logo1.png?where=super",
//      title: "title",
//      subtitle: "subtitle",
//    );
//  }

  @override
  Widget build(BuildContext context) {
    Widget adUnitSide = Container(
      width: scaleSize(context, 1850, 300),
      height: scaleSize(context, 1850, 250),
    );

    var _titleTextColor = Color.fromRGBO(0, 0, 0, 0.87);
    var _subtitleTextColor = Color.fromRGBO(0, 0, 0, 0.54);

    Widget imageWrapper = Container(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: FadeInImage(
          image: url != null ? NetworkImage(url) : NetworkImage(""),
          placeholder: AssetImage('images/default_album.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );

    return Column(
      children: <Widget>[
        imageWrapper,
        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 4),
//                child: Row(
//                  children: <Widget>[
//                    Text(
//                      title,
//                      style: Theme.of(context).textTheme.display1.apply(
//                            color: _titleTextColor,
////                            height: 40 / 34,
//                          ),
//                    ),
//                  ],
//                ),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline4.apply(
                        color: _titleTextColor,
//                            height: 40 / 34,
                      ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyText1.apply(
                    color: _subtitleTextColor,
//                          height: 20 / 14,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text(
                  '年代：${record.year}',
                  style: Theme.of(context).textTheme.bodyText2.apply(
                        color: _subtitleTextColor,
//                          height: 20 / 14,
                      ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text(
                  '介质：${record?.getFormatText() ?? '-'}',
                  style: Theme.of(context).textTheme.bodyText1.apply(
                    color: _subtitleTextColor,
//                          height: 20 / 14,
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                child: Text(
                  '唱片公司：${record?.company?.name}',
                  style: Theme.of(context).textTheme.bodyText2.apply(
                    color: _subtitleTextColor,
//                          height: 20 / 14,
                  ),
                ),
              ),
              Container(
                height: 4,
              ),
              ArtistBar(
                artists: record.artists,
              ),

              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
