import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefrence/utils/utils.dart';
import 'package:shared_prefrence/view/login_screen.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  void logout(BuildContext context) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.clear();
      await Future.delayed(const Duration(seconds: 1));
      if (!context.mounted) return;
      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => const LoginScreen())));
      Utils.toastMessage(context, 'Logout Successfully');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () async {
                logout(context);
              },
              child: const Icon(Icons.delete))
        ],
        centerTitle: true,
        title: const Text("StudentScreen"),
      ),
    );
  }
}
