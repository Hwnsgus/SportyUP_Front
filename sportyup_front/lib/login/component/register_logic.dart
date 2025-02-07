import 'package:flutter/material.dart';
import 'package:sportyup_front/login/component/register_text_form_field.dart';


class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("비밀번호가 일치하지 않습니다.")),
      );
      return;
    }

    Navigator.pushReplacementNamed(context, "/login");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("회원가입이 완료되었습니다. 로그인해주세요!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(labelText: "Email", controller: _emailController),
          const SizedBox(height: 20),
          CustomTextFormField(labelText: "Password", controller: _passwordController, obscureText: true),
          const SizedBox(height: 20),
          CustomTextFormField(labelText: "Confirm Password", controller: _confirmPasswordController, obscureText: true),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _register();
              }
            },
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
