import 'package:flash_card/model/fcard.dart';
import 'package:flash_card/screens/add_edit_card.dart';
import 'package:flash_card/widgets/card_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/colors.dart';

class AddEditDeleteCard extends StatelessWidget {
  const AddEditDeleteCard({
    super.key,
    required this.qController,
    required this.aController,
    required this.onAddCard,
    required this.onDeleteCard,
    required this.card,
    required this.onUpdateCard,
  });

  final Fcard card;
  final TextEditingController qController;
  final TextEditingController aController;
  final void Function() onAddCard;

  final void Function(int id) onDeleteCard;
  final void Function(Fcard card) onUpdateCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(horizontal: 40),
      elevation: 4,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(shape: BoxShape.circle, color: bodyCC),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditCard(
                        qController: qController,
                        aController: aController,
                        onAddCard: onAddCard,
                        onUpdateCard: onUpdateCard,
                      ),
                    ));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(shape: BoxShape.circle, color: bodyCC),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditCard(
                        qController: qController,
                        aController: aController,
                        card: card,
                        onAddCard: onAddCard,
                        onUpdateCard: onUpdateCard,
                      ),
                    ));
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(shape: BoxShape.circle, color: bodyCC),
            child: IconButton(
              onPressed: () {
                onDeleteCard(card.id!);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
