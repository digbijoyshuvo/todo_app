import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';

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


// create New Todo file


  Future createNewTodo(String title, String description)async{
    final collection = await databases.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: {
          "title" : title,
          "description" : description,
          "isCompleted" : false,
          "createdBy" : "digbijoy@gmail.com"
        });
    getAllTodo();
    notifyListeners();
  }

// read all todos created by user
Future getAllTodo()async{
  try{
    final data = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: collectionId,);
    todos = data.documents;
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

}