import 'package:flutter/material.dart';
import 'package:sportyup_front/login/component/register_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _userPwdController = TextEditingController();

  Future<void> _login() async {
    if (_userIdController.text == "test" && _userPwdController.text == "1234") {
      Navigator.pushReplacementNamed(context, "/main");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("로그인 실패. 아이디 또는 비밀번호를 확인하세요.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(labelText: "Email", controller: _userIdController),
          const SizedBox(height: 20),
          CustomTextFormField(labelText: "Password", controller: _userPwdController, obscureText: true),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _login();
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, "/register"),
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
