import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoper/features/auth/services/auth_service.dart';
import 'package:shoper/provider/user_controller.dart';
import 'package:shoper/widgets/bottom_navbar.dart';

import 'features/auth/screens/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  AuthService authService = AuthService();


  @override
  void initState() {
    super.initState();
    screenNavigator();
authService.getUserData(context);
 print(Provider.of<UserProvider>(context, listen: false).user.token);
  }

    void screenNavigator() {
    //generate future.delayed and then run any function
    Future.delayed(const Duration(seconds: 5), () {
      Provider.of<UserProvider>(context, listen: false).user.token.isNotEmpty
        ? Navigator.pushNamedAndRemoveUntil(
            context, BottomNavbr.routeName, (route) => false)
        : Navigator.pushNamedAndRemoveUntil(
            context, AuthScreen.routeName, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}