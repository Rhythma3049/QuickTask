part of 'pages.dart';

abstract class Routes {
  static const splash = Paths.splash;
  static const home = Paths.home;
  static const tasks = Paths.tasks;
  static const login = Paths.login;
  static const signup = Paths.signup;
}

abstract class Paths {
  static const splash = '/splash';
  static const home = '/home';
  static const tasks = '/tasks';
  static const login = '/login';
  static const signup = '/signup';
}
