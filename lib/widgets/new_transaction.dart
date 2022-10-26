import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
//import 'package:intl';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selectDate;

  void _SubmitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredText = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredText.isEmpty || enteredAmount <= 0 || selectDate == null) {
      return;
    }
    widget.addTx(
      enteredText, 
      enteredAmount,
      selectDate,
      );
    Navigator.of(context).pop();
  }

  void _presentDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        TextField(
          decoration: InputDecoration(labelText: 'Title:'),
          /*onChanged: (val) {
                          titleInput = val;
                        },*/
          controller: titleController,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Amount:'),
          /*onChanged: (val) {
                          amountInput = val;
                        },*/
          controller: amountController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => _SubmitData(),
        ),
        Row(
          children: [
            Text(selectDate == null
                ? 'No Date Chosen!!'
                : 'Chosen Date: ${DateFormat.yMd().format(selectDate)}'),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: _presentDate,
              child: Text(
                'Choose Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        RaisedButton(
          child: Text('save'),
          color: Theme.of(context).primaryColor,
          textColor: Theme.of(context).textTheme.button.color,
          onPressed: _SubmitData,
        ),
      ]),
    ));
  }
}
