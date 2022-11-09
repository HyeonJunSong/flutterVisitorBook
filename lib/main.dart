import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'visitorBook/view/visitor_book_page.dart';
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
          initialRoute: "/VisitorBookPage",
          getPages: [
            // GetPage(name: "/Load", page: () => LoadingPage(), transition: Transition.fadeIn, binding: BindingsBuilder(
            //         () => Get.lazyPut<clientController>(() => clientController()))),
            GetPage(
              name: "/VisitorBookPage",
              binding: BindingsBuilder(() => Get.lazyPut<VisitorBookViewController>(() => VisitorBookViewController())),
              page: () => VisitorBookPage(),
              transition: Transition.fadeIn,
            ),
          ],
        );
      },
    );
  }
}