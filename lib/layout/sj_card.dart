import 'package:flutter/material.dart';

class SJCard extends StatelessWidget {
  String title = 'Cinematic Ambience';
  String description = 'Relaxing film scores for peaceful reflection.';

//  String imageUrl =
//      'https://lh3.googleusercontent.com/5I7twkpomIJVpEpPEyF2M7ZI-yewpHCnk-ruXIEdlU-VysNbFpWtPDSM=w700-h140-p-e100-rwu-v1';

  String imageUrl =
      'https://www.baidu.com/img/dong_96c3c31cae66e61ed02644d732fcd5f8.gif';

  SJCard();

  factory SJCard.forDesignTime() {
    return new SJCard();
  }

  @override
  Widget build(BuildContext context) {
    title = title + title + title + title;
    description =
        description + description + description + description + description;

    return new Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(const Radius.circular(2)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // imageWrapper
          AspectRatio(
            aspectRatio: 100 / 20,
            child: Container(
              color: Colors.black,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Image.network(imageUrl),
                  ),
                  Positioned.fill(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              color: Colors.red.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              color: Colors.orange.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              color: Colors.yellow.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              color: Colors.green.withOpacity(0.5),
                            ),
                          ),
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              color: Colors.blue.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // details
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxHeight: 36),
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color.fromRGBO(33, 33, 33, 1),
                      fontSize: 16,
                      height: 18 / (16 + 18 - 16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  constraints: BoxConstraints(maxHeight: 48),
                  child: Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color.fromRGBO(117, 117, 117, 1),
                      fontSize: 12,
                      height: 16 / (12 + 16 - 12),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
