import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/todo_provider.dart';
import 'package:todo_app/widgets/custom_snack_bar.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';
import 'package:todo_app/widgets/elevated_button.dart';

class EditTodoView extends StatefulWidget {
  final Document todo;
  const EditTodoView({super.key,required this.todo});

  @override
  State<EditTodoView> createState() => _EditTodoViewState();
}


class _EditTodoViewState extends State<EditTodoView> {
  late TextEditingController _titleController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();
  bool isCompleted = false;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.todo.data['title']);
    _descriptionController = TextEditingController(text: widget.todo.data['description']);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  clearText(){
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider provider = Provider.of<TodoProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.today_outlined),
            SizedBox(width: 8,),
            const Text("Update Todo",),
          ],
        ),
      ),
      body: Padding(padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CustomTextFormField(
              controller: _titleController,
              validator: (val){
                if(val!.isEmpty){
                  return "Please fill the title";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              obscureText: false,
              hintText: "Add a title",
              suffix: null, prefixIcon: null,
            ),
            SizedBox(height: 16,),
            CustomTextFormField(
              controller: _descriptionController,
              validator: (val){
                if(val!.isEmpty){
                  return "Please fill the description";
                }
              },
              maxLine: 4,
              keyboardType: TextInputType.text,
              obscureText: false,
              hintText: "Add Description",
              labelText: "Add Description",
              suffix: null, prefixIcon: null,
            ),
            SizedBox(height: 30,),
            RoundedElevatedButton(
                buttonText: "Update Todo",
                onPressed: (){
                  provider.updateTodo(
                      _titleController.text,
                      _descriptionController.text,
                      widget.todo.$id
                  );
                  CustomSnackBar.showSuccess(context, "Todo Updated Successfully");
                  Navigator.pop(context);
                }
            ),
          ],
        ),
      ),
    );
  }
}
