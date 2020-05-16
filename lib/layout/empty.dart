import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  EmptyWidget({this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon ?? Icons.not_interested,
            size: 64,
          ),
          Visibility(
            visible: text?.isNotEmpty ?? false,
            child: Text(text ?? ''),
          ),
        ],
      ),
    );
  }
}
