import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/database/auth.dart';
import 'package:todo_app/routes/route_names.dart';

class CheckUserSession extends StatefulWidget {
  const CheckUserSession({super.key});

  @override
  State<CheckUserSession> createState() => _CheckUserSessionState();
}

class _CheckUserSessionState extends State<CheckUserSession> {
  @override
  void initState(){
    checkUserSession().then((value){
      if(value){
        context.pushReplacementNamed(RouteNames.todo);
      }else{
        context.pushReplacementNamed(RouteNames.login);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body:
        Center(
            child: CircularProgressIndicator()
        ),
      );
  }
}
