import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) => value!.isEmpty ? "$labelText을 입력하세요" : null,
          decoration: InputDecoration(
            hintText: "Enter $labelText",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }
}
