import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutterweb/visitorBook/model/constants.dart';

class NoteWidget extends StatelessWidget {
  final String title;
  final String content;
  final String date;

  const NoteWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.date
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, nw_margin, nw_margin),
      constraints: BoxConstraints(maxWidth: nw_width),
      decoration: _outerBoxDecoration(),
      child: Container(
        padding: _innerPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            _content(),
            _date(),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////content widget
  _title() => FittedBox(
    child: Text(title, style: TextStyle(
      color: Cmain_dark,
      fontSize: nw_FStitle,
      decoration: TextDecoration.none,
    ),),
  );

  _content() => Container(
    width: nw_innerWidth,
    padding: EdgeInsets.all(nw_innerPadding),
    color: Cbackground1,
    child: FittedBox(
      child: Text(content, style: TextStyle(
        color: Cmain_dark,
        fontSize: nw_FScontent,
        decoration: TextDecoration.none,
      ),),
    ),
  );

  _date() => FittedBox(
    child: Text(date, style: TextStyle(
      color: Cmain_dark.withOpacity(0.5),
      fontSize: nw_FSdate,
      decoration: TextDecoration.none,
    ),),
  );

  //////////////////////////////////////////////////////////////////////////////design
  _outerBoxDecoration() => BoxDecoration(
    color: Cmain_light,
    border: Border.all(
      color: Cmain_dark,
      width: nw_borderlineWidth,
    ),
    borderRadius: BorderRadius.all(Radius.circular(nw_radius.w)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 3,
        blurRadius: 7,
        offset: Offset( nw_shadowOffsetRatio, nw_shadowOffsetRatio,), // changes position of shadow
      ),
    ],
  );

  _innerPadding() => EdgeInsets.fromLTRB(
      nw_padding_hor,
      nw_padding_ver,
      nw_padding_hor,
      nw_padding_ver
  );
}

