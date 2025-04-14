import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/auth.dart';
import 'package:todo_app/database/todo_provider.dart';
import 'package:todo_app/routes/route_names.dart';
import 'package:todo_app/theme/app_color.dart';
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
      body: Consumer(
          builder: (context, TodoProvider provider ,chile){
            return ListView.builder(
              itemCount: provider.allTodos.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: (){
                       context.pushNamed(RouteNames.editTodo,
                       extra: provider.allTodos[index]);
                      },
                      leading: Checkbox(
                          fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                            if (states.contains(WidgetState.selected)) {
                              return Colors.green;
                            }
                            return Colors.red;
                          }),
                          value: provider.allTodos[index].data["isCompleted"]??false,
                          onChanged: (value){
                            provider.markCompleted(provider.allTodos[index].$id,
                                !provider.allTodos[index].data["isCompleted"]);
                          }
                      ),
                      title: Text(provider.allTodos[index].data['title']),
                      subtitle: Text(provider.allTodos[index].data['description']),
                    ),
                  ),
                );
              },
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            context.pushNamed(RouteNames.addTodo);
          },
        backgroundColor: AppColor.appColor,
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
