import 'package:app_expenses/models/expense.dart';
import 'package:app_expenses/screens/new_expense.dart';
import 'package:app_expenses/widgets/expense_list.dart';
import 'package:app_expenses/widgets/popup_menu.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  //const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  Category? _selectedCategory;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    _expenses = List.from(allExpenses); // Create a mutable copy of allExpenses
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  // List<Expense> get _filteredExpenses {
  //   return _selectedCategory == null
  //       ? _registeredExpenses
  //       : _registeredExpenses.where((expense) => expense.category == _selectedCategory).toList();
  // }

  bool _matchesCategory(Expense expense) {
    return _selectedCategory == null || expense.category == _selectedCategory;
  }

  bool _matchesSearch(Expense expense) {
    return expense.title.toLowerCase().contains(_searchQuery.toLowerCase());
  }

  List<Expense> get _filteredExpenses {
    return _expenses.where((expense) {
      return _matchesCategory(expense) && _matchesSearch(expense);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Add this new method to your _ExpensesState class
  void _clearFilters() {
    setState(() {
      _selectedCategory = null;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  void _resetToDefaultExpenses() {
    // Remove the old list and replace it with a new one
    _expenses.clear;
    _expenses = List.from(allExpenses);  // Create a copy of allExpenses
  }

  void _resetExpenses() {
    setState(() {
      _resetToDefaultExpenses();
      _clearFilters();
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  //   List<Expense> get _filteredExpenses {
  //   return _registeredExpenses.where((expense) {

  //     final matchesCategory = _selectedCategory == null || expense.category == _selectedCategory;

  //     final matchesSearch = expense.title.toLowerCase().contains(_searchQuery.toLowerCase());

  //     return matchesCategory && matchesSearch;
  //   }).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('My Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetExpenses,
            tooltip: 'Reset',
          ),
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: _clearFilters,
            tooltip: 'Clear Filters',
          ),
          IconButton(icon: Icon(Icons.add), onPressed: _openAddExpenseOverlay),
          FilterPopupButton(
            selectedCategory: _selectedCategory,
            onCategorySelected: (Category? category) {
              setState(() {
                _selectedCategory = category;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Add search bar below AppBar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _updateSearchQuery,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _updateSearchQuery('');
                  },
                ),
                hintText: 'Search expenses...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const Text('The chart'),
          Expanded(
            child: ExpensesList(
              expenses: _filteredExpenses,
              onRemoveExpense: _removeExpense,
            ),
          ),
        ],
      ),
      //   drawer: Drawer(
      //     child: ListView(
      //       children: [
      //         ListTile(title: Text('Home')),
      //         ListTile(title: Text('Settings')),
      //       ],
      //     ),
      //   ),
      //   bottomNavigationBar: Column(
      //     mainAxisSize: MainAxisSize.min,    // how much space the column takes up - min is space of the children.
      //     children: [
      //       Divider(height: 1, color: Colors.black),
      //       BottomNavigationBar(
      //         currentIndex: 0,
      //         onTap: (index) {},
      //         items: [
      //           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.search),
      //             label: 'Search',
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      //   bottomSheet: Container(
      //     color: Colors.orange,
      //     height: 80,
      //     child: Center(child: Text('Bottom Sheet')),
      //   ),
    );
  }
}
