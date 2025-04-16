import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/database/shared_preferences.dart';

import 'auth.dart';

class TodoProvider extends ChangeNotifier{
  TodoProvider(){
    getAllTodo();
  }

  String databaseId = "67fcd7cf00064af7a07a";
  String collectionId = "67fcd7de001c4e77ff94";

//   Define the database
final Databases databases = Databases(client);

List<Document> todos = [];


// get all todos created by a user
List<Document> get allTodos => todos;

  bool _isLoading = false;

//   check if its loading or not
  bool get checkLoading => _isLoading;

// create New Todo file


  Future createNewTodo(String title, String description)async{
    final email = UserSavedData.getEmail;
    final collection = await databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: {
          "title" : title,
          "description" : description,
          "isCompleted" : false,
          "createdBy" : email,
        });
    getAllTodo();
    notifyListeners();
  }


// read all todos created by user
Future getAllTodo()async{
    _isLoading = true;
    notifyListeners();
    final email = UserSavedData.getEmail;
  try{
    final data = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,
    queries: [
      Query.equal("createdBy", email),
    ]);
    todos = data.documents;
    _isLoading =false;
    notifyListeners();
  }catch(ex){
    print(ex);
  }
}

// change the Todo to Completed or Not Completed

Future markCompleted(String id, bool isCompleted )async{

    final data = await databases.updateDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: id,
        data:{
         "isCompleted" : isCompleted,
        });
    print("Document Modified");
    getAllTodo();
    notifyListeners();
}


// Update the whole todo
Future updateTodo(String title, String desc, String id)async{
  final data = await databases.updateDocument(
      databaseId: databaseId,
      collectionId: collectionId,
      documentId: id,
    data: {
     "title" : title,
     "description" : desc,
    });
  print("Todo Modified");

  getAllTodo();
  notifyListeners();
}

// Delete a Todo
Future deleteTodo(String id)async{
    final data = await databases.deleteDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: id);
    getAllTodo();
    notifyListeners();
}
}