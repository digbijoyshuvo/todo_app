import 'package:appwrite/appwrite.dart';
import 'package:todo_app/database/shared_preferences.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('67fbe00e0006a36a0cd7')
    .setSelfSigned(status: true);

//Create An User Account

Account account = Account(client);

Future<String> createUser(
    String name,
    String email,
    String password,

    )async {
    try {
        final user = await account.create(
            userId: ID.unique(),
            name: name,
            email: email,
            password: password,

        );
        print("New User Created");
        return "success";
    }on AppwriteException catch(ex){
        print(ex);
        return ex.message.toString();
    }
}

// Login Function for User

Future<String> loginUser(String email, String password)async{
   try {
       final user = await account.createEmailPasswordSession(
           email: email,
           password: password);
       await UserSavedData.saveEmail(email);
       print("User Logged In");
       return "success";
   }on AppwriteException catch(ex){
       print(ex);
       return ex.message.toString();
   }
}

// Logout Function For User

Future logOutUser()async{
   await account.deleteSession(sessionId: 'current');
   print("User Is logged Out");
}


// Check User Authentication

Future checkUserSession()async{
    try{
      await  account.getSession(sessionId: 'current');
        return true;
    }catch(ex){
        print(ex);
        return false;
    }
}
