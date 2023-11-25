abstract class EndPoint {
  Future fetchExpenses();
  Future postExpense(expenseData);
  Future<void> deleteExpense(expenseId);
  Future updateExpense(expenseId, updatedData);
}

