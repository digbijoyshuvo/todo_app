import 'package:flutter/material.dart';
import 'package:todo_app/widgets/elevated_button.dart';

import '../utils/validation_rule.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _firstNameController =TextEditingController();
  final TextEditingController _lastNameController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  bool isPasswordVisible=false;

  @override
  void dispose(){
    _firstNameController.dispose();
    _lastNameController.dispose();
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
                        controller: _firstNameController,
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
                        controller: _lastNameController,
                        validator: (val){
                          if(val!.isEmpty){
                            return " Please enter your name";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        hintText: "Enter Your last name",
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
                          })
                    ],
                  ) ) ,
          ),
        ),
      ),
    );
  }
}
