import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../view_model/expense_view_model.dart';


deleteDialog(context, name, id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: AlertDialog(
              title: Text('Are you sure you want to delete $name expense ?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent),
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent),
                  child:
                      Text('Delete', style: TextStyle(color: Colors.grey[700])),
                  onPressed: () async {
                    await Provider.of<ExpensesViewModel>(context, listen: false).deleteExpense(id);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }