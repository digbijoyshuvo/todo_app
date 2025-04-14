import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/database/todo_provider.dart';
import 'package:todo_app/widgets/custom_snack_bar.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';
import 'package:todo_app/widgets/elevated_button.dart';

class AddTodoView extends StatefulWidget {
  const AddTodoView({super.key});

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
bool isCompleted = false;

 @override
 void initState() {
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
            const Text("Add a Todo",),
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
              buttonText: "Add Todo",
              onPressed: (){
                provider.createNewTodo(
                    _titleController.text,
                    _descriptionController.text);
                CustomSnackBar.showSuccess(context, "Todo Added Successfully");
                Navigator.pop(context);
              }
          ),
        ],
      ),
      ),
    );
  }
}
