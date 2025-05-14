import 'package:flutter/material.dart';
import 'package:flash_card/colors.dart';

class AddDeck extends StatelessWidget {
  const AddDeck({super.key, required this.onAddDeck});

  final void Function() onAddDeck;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Add Deck'),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: onAddDeck,
              style: ElevatedButton.styleFrom(
                  elevation: 4,
                  fixedSize: Size(60, 60),
                  backgroundColor: bodyC,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                  )),
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
