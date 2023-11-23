import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/expense.dart';
import '../../../../view_model/expense_view_model.dart';
import '../../add_edit_expense/add_edit_expense.dart';
import 'dialogs/delete_dialog.dart';

class CustomCard2 extends StatelessWidget {
  final Expense data;
  final String? id;
  const CustomCard2({Key? key, required this.data, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesViewModel>(context, listen: false);
    const color = Color(0xff177DFF);

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                colors: [color, color.withOpacity(0.8)]),
            color: color,
            borderRadius: BorderRadius.circular(15)),
        width: 320,
        height: 220,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.name,
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    data.total.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                  const Text(
                    "/usd",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () {
                      deleteDialog(context, data.name, id);
                    },
                    label: const Text(
                      "Delete",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.greenAccent,
                    ),
                    onPressed: () async {
                      final editData = {
                        'name': data.name,
                        'total': data.total,
                        'dueDate': data.dueDate,
                        'imageUrl': data.imageUrl,
                        'address': data.address
                      };
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEditExpensesScreen(
                                  processName: 'Edit',
                                  expenseId: id,
                                  data: editData)));
                      if (result != null) {
                        await exProvider.editExpense(result, id);
                      }
                    },
                    label: const Text(
                      "Edit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton.icon(
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.greenAccent,
                      ),
                      onPressed: () async {
                        final clonedData = {
                          'name': data.name,
                          'total': data.total,
                          'dueDate': data.dueDate,
                          'imageUrl': data.imageUrl,
                          'address': data.address
                        };
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEditExpensesScreen(
                                    processName: 'Clone',
                                    expenseId: id,
                                    data: clonedData)));
                        if (result != null) await exProvider.addExpense(result);
                      },
                      label: const Text(
                        "Clone",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
