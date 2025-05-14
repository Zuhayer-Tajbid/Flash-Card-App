import 'package:flutter/material.dart';
import 'package:flash_card/colors.dart';

class CardButton extends StatelessWidget {
  const CardButton(
      {super.key,
      required this.icon,
      required this.qController,
      required this.aController,
      required this.onAddCard});

  final IconData icon;

  final TextEditingController qController;
  final TextEditingController aController;
  final void Function() onAddCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(shape: BoxShape.circle, color: bodyCC),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
