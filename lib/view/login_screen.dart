import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefrence/utils/utils.dart';
import 'package:shared_prefrence/utils/widgets/round_button.dart';
import 'package:shared_prefrence/view/student.dart';
import 'package:shared_prefrence/view/teacher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _selectedRole = 'Student';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('LoginScreen'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width / 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined), hintText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password_outlined),
                  hintText: 'Password'),
            ),
            SizedBox(
              height: height / 50,
            ),
            DropdownButton<String>(
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
              items: <String>['Student', 'Teacher']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Roundbutton(
                title: 'Login',
                onPress: () {
                  login(context);
                })
          ],
        ),
      ),
    );
  }

  login(BuildContext context) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('email', emailController.text.toString());
      sp.setString('password', passwordController.text.toString());
      sp.setString('role', _selectedRole.toString());
      if (!context.mounted) return;
      if (_selectedRole == 'Student') {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const StudentScreen())));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const TeacherScreen())));
      }
      Utils.toastMessage(context, 'Login Successfully');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
