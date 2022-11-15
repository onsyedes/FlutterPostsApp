import 'package:flutter/material.dart';
class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLines;
  final String name;

  const TextFieldWidget({required this.controller , required this.name ,required this.multiLines,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextFormField(
          minLines: multiLines ? 6 : 1,
          maxLines: multiLines ? 6 : 1,
          controller: controller,
          validator: (val) => val!.isEmpty ? "$name Can't be empty" : null,
          decoration: InputDecoration(hintText: name),
        ));
  }
}
