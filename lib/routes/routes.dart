
import 'package:go_router/go_router.dart';
import 'package:todo_app/auth/login_view.dart';
import 'package:todo_app/auth/register_view.dart';
import 'package:todo_app/database/checkUserSession.dart';
import 'package:todo_app/features/todoPage/add_todo_view.dart';
import 'package:todo_app/features/todoPage/todo_page.dart';
import 'package:todo_app/routes/route_names.dart';

import '../features/splash_view.dart';

final GoRouter router = GoRouter(routes:[
  GoRoute(
    name: RouteNames.splash,
    path:"/",
    builder: (context,state) => const SplashView(),
  ),
  GoRoute(
    name: RouteNames.register,
    path:"/register",
    builder: (context,state) => const RegisterView(),
  ),
  GoRoute(
    name: RouteNames.login,
    path:"/login",
    builder: (context,state) => const LoginView(),
  ),
  GoRoute(
    name: RouteNames.todo,
    path:"/todo",
    builder: (context,state) => const TodoPage(),
  ),
  GoRoute(
    name: RouteNames.checkUserAuth,
    path:"/checkUserAuth",
    builder: (context,state) => const CheckUserSession(),
  ),
  GoRoute(
    name: RouteNames.addTodo,
    path:"/addTodo",
    builder: (context,state) => const AddTodoView(),
  ),
]);