import 'package:get/get.dart';
import 'package:quicktask/screens/add_modify_user_screen.dart';
import 'package:quicktask/screens/login_screen.dart';

import '../exports.dart';

part 'routes.dart';

/// Pages
class Pages {
  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: Paths.signup,
      page: () => AddModifyUserScreen(),
    ),
    GetPage(
      name: Paths.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Paths.tasks,
      page: () => TasksView(),
      binding: TasksBinding(),
    ),
  ];
}
