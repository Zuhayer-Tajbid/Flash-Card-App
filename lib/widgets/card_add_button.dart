import 'package:flash_card/model/fcard.dart';
import 'package:flutter/material.dart';

class CardAddButton extends StatelessWidget {
  const CardAddButton(
      {super.key,
      required this.add,
      required this.update,
      required this.ans,
      this.card});

  final bool ans;
  final void Function() add;
  final void Function(Fcard card) update;
  final Fcard? card;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (ans) {
            add();
          } else if (card != null) {
            update(card!);
          }
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 215, 119, 193),
        ),
        child: Text(
          'Save',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ));
  }
}
