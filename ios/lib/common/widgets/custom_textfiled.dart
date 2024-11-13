import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomTextfiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextfiled({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          )),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black38,
          ))),
      validator: (val) {},
    );
  }
}
