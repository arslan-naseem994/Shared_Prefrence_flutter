import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefrence/view/student.dart';
import 'package:shared_prefrence/view/login_screen.dart';
import 'package:shared_prefrence/view/teacher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  isLogin(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
     if (!context.mounted) return;
    if (sp.getString('email') == null || sp.getString('email') == '') {
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const LoginScreen())));
    } else {
      if (sp.getString('role') == 'Student') {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const StudentScreen())));
      }
      if (sp.getString('role') == 'Teacher') {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const TeacherScreen())));
      }
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      isLogin(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'SplashScreen',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'SplashScreen',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
