import 'package:app_expenses/models/expense.dart';
import 'package:flutter/material.dart';

class FilterPopupButton extends StatelessWidget {
  final Category? selectedCategory;
  final Function(Category?) onCategorySelected;

  const FilterPopupButton({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: PopupMenuButton(
        initialValue: selectedCategory,
        child: Text(
          'Filter Category',
          style: TextStyle(color: Colors.blue), // <-- Style your button here
        ),
        itemBuilder:
            (context) => [
              PopupMenuItem(value: Category.food, child: Focus(autofocus: true, child: Text('Food'))),
              PopupMenuItem(value: Category.leisure, child: Text('leisure')),
              PopupMenuItem(value: Category.travel, child: Text('travel')),
              PopupMenuItem(value: Category.work, child: Text('work')),
            ],
        onSelected: (result) {
          onCategorySelected(result);
        },
      ),
    );
  }
}
