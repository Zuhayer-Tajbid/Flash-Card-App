import 'package:flash_card/colors.dart';
import 'package:flash_card/model/fcard.dart';
import 'package:flash_card/widgets/card_add_button.dart';
import 'package:flash_card/widgets/qa_field.dart';
import 'package:flutter/material.dart';

class AddEditCard extends StatefulWidget {
  const AddEditCard(
      {super.key,
      required this.qController,
      required this.aController,
      required this.onAddCard,
      required this.onUpdateCard,
       this.card,
      });

  final TextEditingController qController;
  final TextEditingController aController;
  final void Function() onAddCard;
  final void Function(Fcard card) onUpdateCard;
final Fcard ?card;

  @override
  State<AddEditCard> createState() => _AddEditCardState();
}

class _AddEditCardState extends State<AddEditCard> {
bool addCard=true;
@override
  void initState() {
    super.initState();

    // Only populate the controllers if we're editing a card
    if (widget.card != null) {
      addCard=false;
      widget.qController.text = widget.card!.question;
      widget.aController.text = widget.card!.answer;
    }
  }


  @override
  Widget build(BuildContext context) {



var title=addCard?'Add':'Update';



    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: bodyCC,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: bodyC,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
QaField(controller: widget.qController,tag: 'Question',),
              const SizedBox(height: 30,),
               QaField(controller: widget.aController,tag: 'Answer',),
              const SizedBox(height: 130,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    TextButton(onPressed: (){
      Navigator.pop(context);
    }, 
    
    child: Text('Cancel',style: TextStyle(color: const Color.fromARGB(255, 215, 119, 193),fontSize: 20),),),
    const SizedBox(width: 15,),
CardAddButton(add: widget.onAddCard,update:widget.onUpdateCard,ans: addCard,card: widget.card,),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
