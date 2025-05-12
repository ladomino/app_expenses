import 'package:app_expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// Alternate ListTile presentation
class ExpenseListTileItem extends StatelessWidget {
  const ExpenseListTileItem(
    this.expense, {
    super.key,
    required this.onRemoveExpense,
  });

  final Expense expense;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onRemoveExpense(expense),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Remove',
          ),
        ],
      ),
      child: Card(
        color: Theme.of(context).cardColor,
        child: ListTile(
          leading: Icon(categoryIcons[expense.category]),
          title: Text(expense.title),
          subtitle: Text(expense.formattedDate),
          trailing: Text(
            '\$${expense.amount.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),
    );
  }
}

// Card presentation
class ExpenseCardItem extends StatelessWidget {
  const ExpenseCardItem(
    this.expense, {
    super.key,
    required this.onRemoveExpense,
  });

  final Expense expense;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => onRemoveExpense(expense),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Remove',
          ),
        ],
      ),
      child: Card(
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Text(expense.title),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}'),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category]),
                      const SizedBox(width: 8),
                      Text(expense.formattedDate),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
