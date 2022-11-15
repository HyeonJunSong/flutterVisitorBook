import 'package:flutter/material.dart';
import 'package:flutterweb/visitorBook/view/gridView/visitor_book_page_grid.dart';
import 'package:flutterweb/visitorBook/view/listView/note_page.dart';
import 'package:flutterweb/visitorBook/view/listView/visitor_book_page_list.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'visitorBook/viewController/visitor_book_view_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: (context, child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/VisitorBookPageList",
          getPages: [
            // GetPage(name: "/Load", page: () => LoadingPage(), transition: Transition.fadeIn, binding: BindingsBuilder(
            //         () => Get.lazyPut<clientController>(() => clientController()))),
            GetPage(
              name: "/VisitorBookPageList",
              binding: BindingsBuilder(() => Get.lazyPut<VisitorBookViewController>(() => VisitorBookViewController())),
              page: () => VisitorBookPageList(),
              transition: Transition.fadeIn,
            ),
            GetPage(
              name: "/VisitorBookPageGrid",
              binding: BindingsBuilder(() => Get.lazyPut<VisitorBookViewController>(() => VisitorBookViewController())),
              page: () => VisitorBookPageGrid(),
              transition: Transition.fadeIn,
            ),
          ],
        );
      },
    );
  }
}