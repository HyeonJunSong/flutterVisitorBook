import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterweb/visitorBook/model/constants.dart';
import 'package:get/get.dart';

class NoteWidgetList extends StatelessWidget {
  NoteWidgetList({
    Key? key,
    required this.title,
    required this.content,
    required this.date
  }) : super(key: key);

  String title;
  String content;
  String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1800.w,
      height: 200.h,
      margin: EdgeInsets.only(top: 50.h),
      padding: EdgeInsets.all(40.h),
      decoration: BoxDecoration(
        color: Cmain_dark,
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(title, style: TextStyle(
              color: Cbackground1,
              fontSize: 40.h,
            ),),
          ),
          Flexible(
            child: Text(content, style: TextStyle(
              color: Cbackground1,
              fontSize: 20.h,
              height: 1.7.h
            ),),
          ),
    ],
      ),
    );
  }
}
