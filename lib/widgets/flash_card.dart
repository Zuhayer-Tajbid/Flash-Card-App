import 'package:flutter/material.dart';

class FlashCard extends StatelessWidget {
  const FlashCard({super.key, required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      color: color,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 350,
        width: 350,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
                fontFamily: 'quick', fontSize: 25, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        )),
      ),
    );
  }
}
