import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/database/auth.dart';
import 'package:todo_app/routes/route_names.dart';
import 'package:todo_app/widgets/custom_snack_bar.dart';
import 'package:todo_app/widgets/elevated_button.dart';

import '../utils/validation_rule.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  bool isPasswordVisible=false;

  @override
  void dispose(){
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              child:Form(
                  child:Column(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(height: 16,),
                      CustomTextFormField(
                        controller: _nameController,
                        validator: (val){
                          if(val!.isEmpty){
                            return " Please enter your name";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        hintText: "Enter Your first name",
                        suffix: null,
                        prefixIcon: Icon(Icons.person),
                      ),
                      SizedBox(height: 10,),
                      CustomTextFormField(
                        controller: _emailController,
                        validator: (val){
                          if(val!.isEmpty){
                            return " Please enter your name";
                          }else if(!ValidationRules.emailValidation.hasMatch(val)){
                            return "Please Enter a Valid Email";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        hintText: "Enter Your Email",
                        suffix: null,
                        prefixIcon: Icon(Icons.email),
                      ),
                      SizedBox(height: 10,),
                      CustomTextFormField(
                        controller: _passwordController,
                        validator: (val){
                          if(val!.isEmpty){
                            return " Please enter your password";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !isPasswordVisible,
                        hintText: "Enter Your Password",
                        suffix: InkWell(
                          onTap: () {
                            setState(() {
                              isPasswordVisible = ! isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      SizedBox(height: 16,),
                      RoundedElevatedButton(
                          buttonText: "Register",
                          onPressed: (){
                            createUser(
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text
                            ).then((value){
                              if(value=="success"){
                                context.pushReplacementNamed(RouteNames.login);
                                CustomSnackBar.showSuccess(context, "Account Created");
                              }else{
                                CustomSnackBar.showInfo(context, value);
                              }
                            });
                          })
                    ],
                  ) ) ,
          ),
        ),
      ),
    );
  }
}
