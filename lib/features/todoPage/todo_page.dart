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
  int _selectedIndex = 0;
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
            return provider.checkLoading?
                Center(child: CircularProgressIndicator()):
              provider.allTodos.isEmpty
                ?Center(
              child: Text("No Todos Created",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.grey),),
            ):ListView.builder(
              itemCount: provider.allTodos.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.black,
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
                      title: Text(provider.allTodos[index].data['title'],style: TextStyle(color: Colors.lightGreen,fontSize: 20,fontWeight: FontWeight.w500),),
                      subtitle: Text(provider.allTodos[index].data['description'],style: TextStyle(fontSize: 15),),
                      trailing: IconButton(
                          onPressed: (){
                            provider.deleteTodo(provider.allTodos[index].$id);
                          },
                          icon: Icon(Icons.delete,color: Colors.red,)),
                    ),
                  ),
                );
              },
            );
          }
      ),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _selectedIndex,
        onTap: (value) =>
        setState(() {
          _selectedIndex = value;
        }),
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.list),label: "Todo List"),
        BottomNavigationBarItem(icon: Icon(Icons.done),label: "Completed"),
      ],backgroundColor: AppColor.appBarColor,),
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
