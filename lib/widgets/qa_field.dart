import 'package:flutter/material.dart';

class QaField extends StatelessWidget {
  const QaField({super.key, required this.controller, required this.tag});

  final TextEditingController controller;
  final String tag;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        minLines: 4, // <-- Start with 8 lines tall
        maxLines: null, // <-- Allow it to grow infinitely if needed
        keyboardType: TextInputType.multiline,
        controller: controller,
        style: TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          labelText: tag,
          floatingLabelBehavior:
              FloatingLabelBehavior.always, // <-- This keeps label on top
          hintText: 'Type your ${tag.toLowerCase()} here...',
          hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          labelStyle: TextStyle(fontSize: 25, color: Colors.black),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.black)),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.purple)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.black)),
        ),
      ),
    );
  }
}
