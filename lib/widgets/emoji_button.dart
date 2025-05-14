import 'package:flash_card/model/fcard.dart';
import 'package:flutter/material.dart';

class EmojiButton extends StatelessWidget {
  const EmojiButton(
      {super.key,
      required this.emoji,
      required this.color,
      required this.card,
      required this.isDone,
      required this.isForgotten,
      required this.function});

  final String emoji;
  final Color color;
  final Fcard card;
  final int isDone;
  final int isForgotten;
  final void Function(Fcard card) function;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: CircleBorder(),
      child: InkWell(
        onTap: () {
          Fcard ucard = Fcard(
              deckId: card.deckId,
              id: card.id,
              question: card.question,
              answer: card.answer,
              isDone: isDone,
              isForgotten: isForgotten);
          function(ucard);
        },
        splashColor: Colors.white,
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            image:
                DecorationImage(image: AssetImage('assets/images/$emoji.png')),
          ),
        ),
      ),
    );
  }
}
