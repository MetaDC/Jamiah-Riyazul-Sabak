import 'package:go_router/go_router.dart';
import 'package:jamiah_riyazul_sabak/model/studentmodel.dart';
import 'package:jamiah_riyazul_sabak/view/splash_screen/splashscreen.dart';
import 'package:jamiah_riyazul_sabak/view/student_search_view.dart';
import 'package:jamiah_riyazul_sabak/view/studentdetailpage.dart';

import '../view/newrecordform.dart';

class Routes {
  static const splash = "/";
  static const home = "/home";
  static const studentDetail = "/student";
  static const addRecord = "/add-record";
}

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: Routes.home,
      builder: (context, state) => const StudentSearchPage(),
    ),

    /// 🔹 STUDENT DETAIL PAGE
    GoRoute(
      path: Routes.studentDetail,
      builder: (context, state) {
        final student = state.extra as Studentmodel;
        return StudentDetailPage(student: student);
      },
    ),

    /// 🔹 ADD RECORD PAGE
    GoRoute(
      path: Routes.addRecord,
      builder: (context, state) {
        final student = state.extra as Studentmodel;
        return NewRecordForm(student: student);
      },
    ),
  ],
);
