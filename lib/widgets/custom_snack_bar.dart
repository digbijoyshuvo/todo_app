import 'package:flutter/material.dart';
class CustomSnackBar{
  static void showSuccess(BuildContext context,String message){
    _showSnackBar(context,message,Colors.green);
  }

  static void showInfo(BuildContext context,String message){
    _showSnackBar(context,message,Colors.blue);
  }

  static void showError(BuildContext context,String message){
    _showSnackBar(context,message,Colors.red);
  }

  static void _showSnackBar(BuildContext context,String message,Color color){
    WidgetsBinding.instance.addPostFrameCallback((_){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text(
          message,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
          ),
        ),
          backgroundColor: color,
        ),
      );
    });
  }

}