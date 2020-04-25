import 'package:flutter/material.dart';

import '../layout/artist_bar.dart';
import '../layout_swNdp/record_detail_header_swndp.dart';
import '../model/record.dart';
import '../util.dart';

class Sw600dpRecordDetailHeaderContainer
    extends SwNdpRecordDetailHeaderContainer {
  final String url;
  final String title;
  final String subtitle;

  Sw600dpRecordDetailHeaderContainer({
    Key key,
    this.url,
    this.title,
    this.subtitle,
    Record record,
  }) : super(record: record);

  factory Sw600dpRecordDetailHeaderContainer.forDesignTime() {
    // TODO: add arguments
    return new Sw600dpRecordDetailHeaderContainer(
      url: "https://www.baidu.com/img/bd_logo1.png?where=super",
      title: "title",
      subtitle: "subtitle",
    );
  }

  @override
  Widget build(BuildContext context) {
    double scale = getScale(context, 'xl');

    Widget adUnitSide = Container(
      width: getSize(context, 300, 'xl'),
      height: 250,
    );

    var _titleTextColor = Color.fromRGBO(0, 0, 0, 0.87);
    var _subtitleTextColor = Color.fromRGBO(0, 0, 0, 0.54);

    Widget imageWrapper = Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: Container(
          color: Colors.black,
          child: FadeInImage(
            width: 180,
            height: 180,
            image: NetworkImage(url),
            placeholder: AssetImage('images/default_album.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: 64 * scale, bottom: 44 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  imageWrapper,
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
//                          child: Row(
//                            children: <Widget>[
//                              Text(
//                                title,
//                                maxLines: 1,
//                                overflow: TextOverflow.ellipsis,
//                                softWrap: false,
//                                style:
//                                    Theme.of(context).textTheme.display1.apply(
//                                          color: _titleTextColor,
////                            height: 40 / 34,
//                                        ),
//                              ),
//                            ],
//                          ),
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.display1.apply(
                                    color: _titleTextColor,
//                            height: 40 / 34,
                                  ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text(
                              'Khalid',
                              style: Theme.of(context).textTheme.body1.apply(
                                    color: _subtitleTextColor,
//                          height: 20 / 14,
                                  ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 4),
                            child: Text(
                              subtitle,
                              style: Theme.of(context).textTheme.body1.apply(
                                    color: _subtitleTextColor,
//                          height: 20 / 14,
                                  ),
                            ),
                          ),
                          Container(
                            height: 4,
                          ),
                          Container(
                            child: ArtistBar(
                              artists: record.artists,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            child: Text(
                              record.company.name,
                              style: Theme.of(context).textTheme.body1.apply(
                                color: _subtitleTextColor,
//                          height: 20 / 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: adUnitSide,
          ),
        ],
      ),
    );
  }
}
