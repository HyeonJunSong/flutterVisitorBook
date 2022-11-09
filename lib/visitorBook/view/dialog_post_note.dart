import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterweb/visitorBook/viewController/visitor_book_view_controller.dart';
import 'package:get/get.dart';
import 'package:flutterweb/visitorBook/model/constants.dart';
import 'package:intl/intl.dart';
import 'package:flutterweb/visitorBook/model/note.dart';

class DialogPostNote extends StatefulWidget {
  DialogPostNote({Key? key}) : super(key: key);

  @override
  State<DialogPostNote> createState() => _DialogPostNoteState();
}

class _DialogPostNoteState extends State<DialogPostNote> {
  final formKey = GlobalKey<FormState>();
  String title = "";
  String content = "";
  int submitButtonState = 0; // 0: enabled, 1: Loading, 2: disabled

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Cbackground1,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(nw_radius.w)),
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: dpn_hight, maxWidth: dpn_width),
        padding: EdgeInsets.all(dpn_padding),
        decoration: _lightBoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _title_newNote(),
            _inputBox(),
            _submitButton(),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////content widgets
  _title_newNote() => FittedBox(
    child: Text("새로운 노트", style: TextStyle(
      color: Cmain_dark,
      fontSize: dpn_TitleSize,
    ),),
  );

  _inputBox() => Container(
    decoration: _darkBoxDecoration(),
    padding: EdgeInsets.all(dpn_innerPadding),
    child: Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _titleInputBox(),
          _contentInputBox(),
        ],
      ),
    ),
  );

  _titleInputBox() => Container(
    // width: dpn_inputWidth,
    // height: dpn_inputTitleHeight,

    child: TextFormField(
      style: TextStyle(
        fontSize: dpn_inputTitleSize,
        color: Cmain_dark,
      ),
      decoration: _titleInputDecoration(),
      maxLines: 1,
      validator: (value){
        if(value!.length > 10){
          return "제목은 최대 10글자 입니다.";
        }
        else if(value!.length == 0){
          return "제목은 필수입니다.";
        }
        else {
          return null;
        }
      },
      onSaved: (value){
        title = value!;
      },
      onChanged: (value){
        if(!(this.formKey.currentState!.validate()) && submitButtonState == 0){ setState(() { submitButtonState = 2; });}
        else if(submitButtonState == 2 && this.formKey.currentState!.validate()){ setState(() { submitButtonState = 0; });}
      },
      enabled: submitButtonState != 1,
    ),
  );

  _contentInputBox() => Container(
    // width: dpn_inputWidth.w,
    // height: dpn_inputContentHeight.h,
    child: TextFormField(
      style: TextStyle(
        fontSize: dpn_inputContentSize,
        color: Cmain_dark,
      ),
      decoration: _contentInputDecoration(),
      maxLines: 10,
      validator: (value){
        if(value!.length > 100){
          return "내용은 최대 100글자 입니다.";
        }
        else if(value!.length == 0){
          return "내용은 필수입니다.";
        }
        else {
          return null;
        }
      },
      onSaved: (value){
        content = value!;
      },
      onChanged: (value){
        if(!(this.formKey.currentState!.validate()) && submitButtonState == 0){ setState(() { submitButtonState = 2; });}
        else if(submitButtonState == 2 && this.formKey.currentState!.validate()){ setState(() { submitButtonState = 0; });}
      },
      enabled: submitButtonState != 1,
    ),
  );

  _submitButton() => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Cmain_light,
//      fixedSize: Size(dpn_submitWith.w, dpn_submitHeight.h),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(nw_radius.w)),
          side: BorderSide(
            color: Cmain_dark,
            width: nw_borderlineWidth.w,
          )
      ),
    ),

    onPressed: submitButtonState == 0 ? () {
      formKey.currentState!.save();
      setState((){ submitButtonState = 1;});
      Future<int> postNoteResult = Get.find<VisitorBookViewController>().postNote(title, content);
      postNoteResult.then((value) {
        switch (value){
          case 200:
            Get.find<VisitorBookViewController>().getNotes();
            Get.back();
            break;
          default:
            Get.snackbar("error", "");
            setState((){ submitButtonState = 0;});
        }
      });
    } : null,
    child: submitButtonState != 1 ?
    FittedBox(
      child: Text("Submit", style: TextStyle(
          fontSize: dpn_submitSize,
          color: Cmain_dark
      ),),
    ) :
    Container(
      padding: EdgeInsets.all(10),
      child: CircularProgressIndicator(
        color: Cmain_dark,
      ),
    ),
  );

  //////////////////////////////////////////////////////////////////////////////design

  _lightBoxDecoration() => BoxDecoration(
    color: Cbackground1,
    borderRadius: BorderRadius.all(Radius.circular(nw_radius.w)),
    border: Border.all(
      color: Colors.transparent
    )
  );

  _darkBoxDecoration() => BoxDecoration(
      color: Cmain_light,
      border: Border.all(
      color: Cmain_dark,
      width: nw_borderlineWidth.h,
    ),
    borderRadius: BorderRadius.all(Radius.circular(nw_radius.w)),
  );

  _titleInputDecoration() => InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(dpn_inputPadWidth.w, dpn_inputTitlePadHeight.h, dpn_inputPadWidth.w, dpn_inputTitlePadHeight.h),
    hintText: '10자 이내',
    labelText: '제목',
    labelStyle: TextStyle(
        color: Cmain_dark,
        fontSize: dpn_inputTitleSize
    ),
    enabledBorder: _inputBorder(),
    focusedBorder: _inputBorder(),
    errorBorder: _inputBorder(),
    focusedErrorBorder: _inputBorder(),
    filled: true,
    fillColor: Cbackground1,
    floatingLabelAlignment: FloatingLabelAlignment.center,
    floatingLabelStyle: TextStyle(
        fontSize: dpn_inputFloatLabelSize,
        color: Cmain_dark
    ),
    helperText: "",
  );

  _contentInputDecoration() => InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(dpn_inputPadWidth.w, dpn_inputContentPadHeight.h, dpn_inputPadWidth.w, dpn_inputContentPadHeight.h),
    hintText: '100자 이내',
    labelText: '내용',
    labelStyle: TextStyle(
        color: Cmain_dark,
        fontSize: dpn_inputContentSize
    ),
    enabledBorder: _inputBorder(),
    focusedBorder: _inputBorder(),
    errorBorder: _inputBorder(),
    focusedErrorBorder: _inputBorder(),
    filled: true,
    fillColor: Cbackground1,
    floatingLabelAlignment: FloatingLabelAlignment.center,
    floatingLabelStyle: TextStyle(
        fontSize: dpn_inputFloatLabelSize,
        color: Cmain_dark
    ),
    helperText: "",
  );

  _inputBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.w)),
    borderSide: BorderSide(
      color: Colors.transparent,
    ),
  );
}
