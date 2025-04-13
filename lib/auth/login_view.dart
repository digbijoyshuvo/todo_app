import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/routes/route_names.dart';
import 'package:todo_app/theme/app_color.dart';
import 'package:todo_app/utils/validation_rule.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';
import 'package:todo_app/widgets/elevated_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            child: Form(
                child:Column(
                  children: [
                    Image.asset("assets/images/logo.png",
                    height:100,
                    width: 100,),
                    SizedBox(height: 10,),
                    CustomTextFormField(
                        controller: _emailController,
                        validator: (val) {
                         if(val!.isEmpty) {
                           return "Please Enter Your Email";
                         }else if (!ValidationRules.emailValidation.hasMatch(val)){
                           return "Please Provide a Valid Email";
                         }
                         return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        hintText: "Enter Your Email",
                        suffix: null,
                      prefixIcon: Icon(Icons.email,),
                    ),
                    SizedBox(height: 10,),
                    CustomTextFormField(
                      controller: _passwordController,
                      validator: (val) {
                        if(val!.isEmpty) {
                          return "Please Enter Your Password";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isPasswordVisible,
                      hintText: "Enter Your Password",
                      suffix: InkWell(
                        onTap: (){
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Icon(
                          isPasswordVisible?Icons.visibility:Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock,),
                    ),
                    SizedBox(height: 20,),
                    RoundedElevatedButton(
                        buttonText: "Login",
                        onPressed: (){}
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        context.pushNamed(RouteNames.register);
                      },
                      child: RichText(text: TextSpan(
                        text: "Don't have an Account? ",
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: "Register",
                            style: TextStyle(color: AppColor.appColor,fontWeight: FontWeight.w600)
                          )
                        ],
                      )),
                    ),
                  ],
                )),
          ),
        ),
      ),

    );
  }
}
