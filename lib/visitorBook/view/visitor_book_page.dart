import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterweb/visitorBook/model/note.dart';
import 'package:get/get.dart';
import 'package:flutterweb/visitorBook/model/constants.dart';
import 'package:flutterweb/visitorBook/view/dialog_post_note.dart';
import 'package:flutterweb/visitorBook/view/note_widget.dart';
import 'package:flutterweb/visitorBook/viewController/visitor_book_view_controller.dart';

class VisitorBookPage extends StatefulWidget {
  const VisitorBookPage({Key? key}) : super(key: key);

  @override
  State<VisitorBookPage> createState() => _VisitorBookPageState();
}

class _VisitorBookPageState extends State<VisitorBookPage> {
  @override
  initState(){
    super.initState();
    Get.find<VisitorBookViewController>().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(VisitorBookViewController());
    return Container(
      padding: EdgeInsets.symmetric(
          vertical : vbp_padding_ver,
          horizontal : vbp_padding_hor.h,
      ),
      decoration: _mainBoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _titleAndButton(),
            _visitorBookLists(context),
          ],
        ),
      ),
    );
    //   Column(
  }

  //////////////////////////////////////////////////////////////////////////////title and button
  _titleAndButton() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox( width: vbp_buttonDia.w,),
      _title(),
      _addNoteButton(),
    ],
  );

  _title() => Text("Welcome!", style: TextStyle(
      fontSize: vbp_welcomeFS.sp,
      color: Cmain_dark,
      decoration: TextDecoration.none
  ),);

  _addNoteButton() => ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: Cmain_light,
        shape: const CircleBorder(),
        fixedSize: Size(vbp_buttonDia.w, vbp_buttonDia.w),
        side: const BorderSide(color: Cmain_dark, width: vbp_buttonborder)
    ),
    child: Icon(Icons.add, size: vbp_buttonIcon.w,),
    onPressed: (){
      Get.dialog(DialogPostNote());
    },
  );

  //////////////////////////////////////////////////////////////////////////////visitor Books
  _visitorBookLists(BuildContext context) => Obx(() {
    int numRow = ((context.width - vbp_padding_hor * 2) / (nw_width + nw_margin)).toInt();
    if(numRow == 0) numRow = 1;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [for(int i = 0; i < numRow; i++) i].map((element) =>
          Column(
            children: Get.find<VisitorBookViewController>().notes
                .where((item) => Get.find<VisitorBookViewController>().notes.indexOf(item) % numRow == element)
                .map((note) => NoteWidget(
              title: note.title,
              // userId: note.userId,
              content: note.content,
              date: note.date,
            )).toList(),
          )
      ).toList(),
    );
  });

  //////////////////////////////////////////////////////////////////////////////design
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