import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/routes/route_names.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     context.pushReplacementNamed(RouteNames.checkUserAuth);
  //   });
  //   super.initState();
  // }
  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds before navigating
    Future.delayed(const Duration(seconds: 2), () {
      context.pushReplacementNamed(RouteNames.checkUserAuth);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png",width: 120,height: 120,),
      ),
    );
  }
}
