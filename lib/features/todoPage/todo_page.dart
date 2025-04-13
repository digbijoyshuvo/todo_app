import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/database/auth.dart';
import 'package:todo_app/routes/route_names.dart';
import 'package:todo_app/widgets/custom_snack_bar.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List",style: TextStyle(fontSize: 20),),
        actions: [
          IconButton(onPressed: (){
            logOutUser();
            context.pushReplacementNamed(RouteNames.login);
            CustomSnackBar.showInfo(context,"Logout Successful");
          },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text("Welcome To Todo List",
        style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
