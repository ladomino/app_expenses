import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

final List<Expense> _allExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Pizza',
      amount: 25.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Disney World',
      amount: 4577.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];
  
// Add this getter
List<Expense> get allExpenses => List.unmodifiable(_allExpenses);


class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseCollection {
  final Map<String, Expense> _expenses = {};

  void addExpense(Expense expense) {
    _expenses[expense.id] = expense;
  }

  void removeExpense(String id) {
    _expenses.remove(id);
  }

  List<Expense> getAllExpenses() {
    return _expenses.values.toList();
  }

  List<Expense> getFilteredExpenses({
    Category? category,
    String searchQuery = '',
  }) {
    return _expenses.values.where((expense) {
      final matchesCategory = category == null || expense.category == category;
      final matchesSearch = expense.title.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();
  }
}
