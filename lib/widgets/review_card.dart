import 'package:flash_card/colors.dart';
import 'package:flash_card/model/fcard.dart';
import 'package:flash_card/widgets/add_edit_delete_card.dart';
import 'package:flash_card/widgets/emoji_button.dart';
import 'package:flash_card/widgets/flash_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard(
      {super.key,
      required this.allCard,
      required this.onDoneFunction,
      required this.deckName});
  final String deckName;
  final List<Fcard> allCard;
  final void Function(Fcard card) onDoneFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bodyC,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            allCard.isNotEmpty ? 'Previously forgotten cards' : '',
            style: TextStyle(
                fontFamily: 'quick', color: Colors.black, fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: PageView.builder(
              itemCount: allCard.length + 1,
              controller: PageController(viewportFraction: 1),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => (index != allCard.length)
                  ? Container(
                      width: MediaQuery.of(context).size.width - 40,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          FlipCard(
                            front: FlashCard(
                                color: bodyCC, text: allCard[index].question),
                            back: FlashCard(
                                color: const Color.fromARGB(255, 208, 183, 252),
                                text: allCard[index].answer),
                            direction: FlipDirection.HORIZONTAL,
                            side: CardSide.FRONT,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${index + 1}/${allCard.length}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Text('Remembered'),
                              const SizedBox(
                                height: 5,
                              ),
                              EmojiButton(
                                emoji: "happy",
                                color: Colors.yellow,
                                isDone: 1,
                                isForgotten: 0,
                                card: allCard[index],
                                function: onDoneFunction,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Container(
                            height: 300,
                            width: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/Enthusiastic-bro(1).png'))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Congratulations! \nYou have remembered the whole\n$deckName deck',
                              style: TextStyle(
                                  fontFamily: 'quick',
                                  color: Colors.black,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
