import 'package:app_expenses/models/expense.dart';
import 'package:app_expenses/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 500) {
          return ExpensesGridView(
            expenses: expenses,
            onRemoveExpense: onRemoveExpense,
          );
        } else {
          return ExpensesListView(
            expenses: expenses,
            onRemoveExpense: onRemoveExpense,
          );
        }
      },
    );
  }
}

class ExpensesListView extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  const ExpensesListView({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,

      //      itemBuilder: (ctx, index) => ExpenseCardItem(expenses[index]),
      itemBuilder:
          (ctx, index) => ExpenseListTileItem(
            expenses[index],
            onRemoveExpense: onRemoveExpense,
          ),
    );
  }
}

class ExpensesGridView extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  const ExpensesGridView({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3 / 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children:
          expenses
              .map(
                (expense) =>
                    ExpenseCardItem(expense, onRemoveExpense: onRemoveExpense),
              )
              .toList(),
    );
  }
}
