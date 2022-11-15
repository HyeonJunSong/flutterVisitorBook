import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterweb/visitorBook/model/constants.dart';
import 'package:flutterweb/visitorBook/model/note.dart';
import 'package:flutterweb/visitorBook/model/constants.dart';
import 'package:get/get.dart';

class NotePage extends StatelessWidget {
  NotePage({
    Key? key,
    required this.note,
  }) : super(key: key);

  Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cbackground1,
        elevation: 0,
        leading: ElevatedButton(
          onPressed: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back, size: 40.h, color: Cmain_dark,),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0
          ),
        ),
      ),
      body: Container(
        decoration: _mainBoxDecoration(),
        width: 1920.w,
        height: 1080.h,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _Note(),
            ] + List<Widget>.from(note.comments.map((e) => _comment(e))),
          ),
        )
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////Note
  _Note() => Container(
    width: 1800.w,
    height: 400.h,
    margin: EdgeInsets.only(top: 50.h),
    padding: EdgeInsets.all(40.h),
    decoration: BoxDecoration(
      color: Cmain_dark,
      borderRadius: BorderRadius.circular(20.h),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(note.title, style: TextStyle(
            color: Cbackground1,
            fontSize: 40.h,
          ),),
        ),
        SizedBox(height: 30.h,),
        Flexible(
          child: Text(note.content, style: TextStyle(
              color: Cbackground1,
              fontSize: 30.h,
              height: 1.7.h
          ),),
        ),
      ],
    ),
  );

  //////////////////////////////////////////////////////////////////////////////Comment
  _comment(String comment) => Container(
    width: 1800.w,
    margin: EdgeInsets.only(top: 50.h),
    padding: EdgeInsets.all(40.w),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.comment, size: 20.h,),
        SizedBox( width: 20.w,),
        Flexible(
          child: Text(comment, style: TextStyle(
            fontSize: 20.h
          ),),
        ),
      ],
    ),
  );

  //////////////////////////////////////////////////////////////////////////////Button

  //////////////////////////////////////////////////////////////////////////////Design
  _mainBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Cbackground1,
        Cbackground2,
      ],
    ),
  );

}
