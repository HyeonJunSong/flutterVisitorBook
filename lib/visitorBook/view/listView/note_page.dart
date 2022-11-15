import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterweb/visitorBook/model/constants.dart';
import 'package:flutterweb/visitorBook/model/note.dart';
import 'package:flutterweb/visitorBook/model/constants.dart';
import 'package:flutterweb/visitorBook/viewController/visitor_book_view_controller.dart';
import 'package:get/get.dart';

class NotePage extends StatefulWidget {
  NotePage({
    Key? key,
    required this.noteKey,
    required this.note,
  }) : super(key: key);

  String noteKey;
  Note note;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool addTrigged = false;
  String inputText = "";
  int submitButtonState = 0; // 0: enabled, 1: Loading

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cbackground1,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Container(
            child: Icon(Icons.arrow_back, size: 40.h, color: Cmain_dark,)
          ),
        ),
      ),
      body: GestureDetector(
        onTap: (){
          if(addTrigged){
            setState(() {
              addTrigged = false;
            });
          }
        },
        child: Container(
          decoration: _mainBoxDecoration(),
          width: 1920.w,
          height: 1080.h,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _Note(),
              ] + List<Widget>.from(widget.note.comments.map((e) => _comment(e)))
                + [_addButton()],
            ),
          )
        ),
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
          child: Text(widget.note.title, style: TextStyle(
            color: Cbackground1,
            fontSize: 40.h,
          ),),
        ),
        SizedBox(height: 30.h,),
        Flexible(
          child: Text(widget.note.content, style: TextStyle(
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
  _addButton() => Container(
    margin: EdgeInsets.only(top: 50.h),
    height: 100.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 500),

          width: addTrigged ? 1600.w : 0,
//          height: 1000.w,
          child: addTrigged ?
          TextField(
            cursorColor: Cbackground1,
            style: TextStyle(
              fontSize: 20.h,
              color: Cbackground1,
            ),
            decoration: _contentInputDecoration(),
            onChanged: (value){
              setState(() {
                inputText = value;
              });
            },
            maxLines: 1,
          ): Container()
        ),
        SizedBox(width: 20.w,),
        GestureDetector(
          child: (submitButtonState == 0) ?
          Icon(Icons.add, color: Cmain_dark, size: min(100.w, 100.h),)
          : CircularProgressIndicator(color: Cmain_dark),
          onTap: (submitButtonState == 0) ? (){
            if(addTrigged == false) {
              setState(() {
                addTrigged = true;
              });
            }
            else{
              setState(() {
                submitButtonState = 1;
              });
              Get.find<VisitorBookViewController>().addComment(widget.noteKey, inputText).then((value) {
                setState(() {
                  submitButtonState = 0;
                });
                if(value == 200){
                  setState(() {
                    addTrigged = false;
                  });
                }
              });
            }
          } : (){},
        ),
      ],
    ),
  );

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

  _contentInputDecoration() => InputDecoration(
    contentPadding: EdgeInsets.all(20.h),
    labelText: '댓글 작성',
    labelStyle: TextStyle(
        color: Cbackground1,
        fontSize: 20.h,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    enabledBorder: _inputBorder(),
    focusedBorder: _inputBorder(),
    errorBorder: _inputBorder(),
    focusedErrorBorder: _inputBorder(),
    filled: true,
    fillColor: Cmain_dark,
    isDense: true,
  );

  _inputBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.w)),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );
}
