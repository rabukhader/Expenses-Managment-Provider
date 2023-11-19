import 'package:expenses_managment_app_provider/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/expense_view_model.dart';
import '../add_edit_expense/add_edit_expense.dart';
import '../manage_expenses/widget/dialogs/delete_dialog.dart';

class ExpenseDetails extends StatelessWidget {
  final String id;
  final Expense data;
  const ExpenseDetails({super.key, required this.id, required this.data});

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesViewModel>(context, listen: false);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff177DFF),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                height: MediaQuery.of(context).size.height *0.6,
                width: MediaQuery.of(context).size.width ,
                child: Image.network(data.imageUrl)),
              Text(
                data.name,
                style: const TextStyle(fontSize: 36),
              ),
              Text(
                data.address,
                textAlign: TextAlign.start,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Text(
                'Total : ${data.total.toString()}\$',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                'Due Date : ${data.dueDate}',
                style: const TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      if (result != null)
                        await exProvider.editExpense(result, id);
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
          )),
    );
  }
}
