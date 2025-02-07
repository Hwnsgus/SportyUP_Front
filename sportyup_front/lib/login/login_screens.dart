import 'package:flutter/material.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                LoginForm(), // 로그인 폼 추가
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  final _userPwdController = TextEditingController();

  Future<void> _login() async {
    String userId = _userIdController.text;
    String userPwd = _userPwdController.text;

    if (userId == "test" && userPwd == "1234") {
      Navigator.pushReplacementNamed(context, "/main"); // 로그인 성공 시 메인 화면 이동
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
          TextFormField(
            controller: _userIdController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextFormField(
            controller: _userPwdController,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Password"),
          ),
          SizedBox(height: 20),
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
          )
        ],
      ),
    );
  }
}
