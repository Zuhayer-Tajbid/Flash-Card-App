import 'package:flash_card/colors.dart';
import 'package:flash_card/model/fcard.dart';
import 'package:flash_card/screens/add_edit_card.dart';
import 'package:flash_card/widgets/add_edit_delete_card.dart';
import 'package:flash_card/widgets/emoji_button.dart';
import 'package:flash_card/widgets/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class MainCardWidget extends StatefulWidget {
  const MainCardWidget(
      {super.key,
      required this.allCard,
      required this.qController,
      required this.aController,
      required this.onAddCard,
      required this.onDeleteCard,
      required this.onUpdateCard,
      required this.onDoneFunction,
      required this.deckName});

  final TextEditingController qController;
  final TextEditingController aController;
  final void Function() onAddCard;
  final void Function(int id) onDeleteCard;
  final void Function(Fcard card) onUpdateCard;
  final void Function(Fcard card) onDoneFunction;
  final List<Fcard> allCard;
  final String deckName;

  @override
  State<MainCardWidget> createState() => _MainCardWidgetState();
}

class _MainCardWidgetState extends State<MainCardWidget> {
  bool isAnimate = false;

  void changeAni() {
    if (!isAnimate) {
      setState(() {
        isAnimate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bodyC,
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: PageView.builder(
              itemCount: widget.allCard.length + 1,
              controller: PageController(viewportFraction: 1),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => (index != widget.allCard.length)
                  ? Container(
                      width: MediaQuery.of(context).size.width - 40,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          AddEditDeleteCard(
                            aController: widget.aController,
                            qController: widget.qController,
                            onAddCard: widget.onAddCard,
                            onDeleteCard: widget.onDeleteCard,
                            card: widget.allCard[index],
                            onUpdateCard: widget.onUpdateCard,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          FlipCard(
                            front: FlashCard(
                                color: bodyCC,
                                text: widget.allCard[index].question),
                            back: FlashCard(
                                color: const Color.fromARGB(255, 208, 183, 252),
                                text: widget.allCard[index].answer),
                            direction: FlipDirection.HORIZONTAL,
                            side: CardSide.FRONT,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${index + 1}/${widget.allCard.length}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                    function: widget.onDoneFunction,
                                    card: widget.allCard[index],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Column(
                                children: [
                                  Text('Forgot'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  EmojiButton(
                                    emoji: "sad",
                                    color: Colors.blueGrey,
                                    isDone: 0,
                                    isForgotten: 1,
                                    function: widget.onDoneFunction,
                                    card: widget.allCard[index],
                                  ),
                                ],
                              ),
                            ],
                          )
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
                              'Congratulations! \nYou have completed the \n${widget.deckName} deck',
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
