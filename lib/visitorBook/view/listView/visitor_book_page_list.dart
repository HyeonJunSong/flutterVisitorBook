import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterweb/visitorBook/model/note.dart';
import 'package:flutterweb/visitorBook/view/listView/note_page.dart';
import 'package:flutterweb/visitorBook/view/listView/note_widget_list.dart';
import 'package:get/get.dart';
import 'package:flutterweb/visitorBook/model/constants.dart';
import 'package:flutterweb/visitorBook/widgets/dialog_post_note.dart';
import 'package:flutterweb/visitorBook/view/gridView/note_widget_grid.dart';
import 'package:flutterweb/visitorBook/viewController/visitor_book_view_controller.dart';

class VisitorBookPageList extends StatefulWidget {
  const VisitorBookPageList({Key? key}) : super(key: key);

  @override
  State<VisitorBookPageList> createState() => _VisitorBookPageListState();
}

class _VisitorBookPageListState extends State<VisitorBookPageList> {
  @override
  initState(){
    super.initState();
    Get.find<VisitorBookViewController>().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(VisitorBookViewController());
    return Scaffold(
      body: Container(
        width: 1920.w,
        height: 1080.h,
        padding: EdgeInsets.symmetric(
          vertical : vbp_padding_ver,
          horizontal : vbp_padding_hor.h,
        ),
        decoration: _mainBoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _titleAndButton(),
              _visitorBookLists(),
            ],
          ),
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
      fontSize: vbp_welcomeFS.h,
      color: Cmain_dark,
      decoration: TextDecoration.none
  ),);

  _addNoteButton() => ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: Cmain_dark,
        shape: const CircleBorder(),
        fixedSize: Size(vbp_buttonDia.h, vbp_buttonDia.h),
    ),
    child: Icon(Icons.add, size: vbp_buttonIcon.h, color: Cbackground1,),
    onPressed: (){
      Get.dialog(DialogPostNote());
    },
  );

  //////////////////////////////////////////////////////////////////////////////visitor Books
  _visitorBookLists() => Obx(() => Column(
    children: List<Widget>.from(Get.find<VisitorBookViewController>().notes.entries.map((element)
      => GestureDetector(
        child: NoteWidgetList(
          title: element.value.title,
          content: element.value.content,
          date: element.value.date
        ),
        onTap: (){
          Get.to(() => NotePage(noteKey: element.key, note: element.value), transition: Transition.rightToLeftWithFade);
        },
      )
    ))
  ));

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