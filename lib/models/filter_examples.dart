import 'package:flutter/material.dart';

/*
User-driven filtering via UI controls"
This typically involves:

A TextField, Dropdown, CheckboxListTile, etc.

Filtering the data based on the selected input.

Rebuilding the UI with the filtered results.*/

class FilterableListExample extends StatefulWidget {
  @override
  _FilterableListExampleState createState() => _FilterableListExampleState();
}

class _FilterableListExampleState extends State<FilterableListExample> {
  final List<String> names = ['Alice', 'Bob', 'Charlie', 'David'];
  String filter = '';

  @override
  Widget build(BuildContext context) {
    final filteredNames =
        names
            .where((name) => name.toLowerCase().contains(filter.toLowerCase()))
            .toList();

    return Column(
      children: [
        TextField(
          onChanged: (value) {
            setState(() => filter = value);
          },
          decoration: InputDecoration(labelText: 'Search names'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredNames.length,
            itemBuilder:
                (context, index) => ListTile(title: Text(filteredNames[index])),
          ),
        ),
      ],
    );
  }
}

/* 
Presenting data based on a rule or predefined filter"
Here, the user doesn’t choose the filter — you control it via logic, such as:

Sort top users by score.

Show only overdue tasks.

Default views like “Recent Orders”.

*/
class PreFilteredList extends StatelessWidget {
  final List<Map<String, dynamic>> users = [
    {'name': 'Alice', 'age': 25},
    {'name': 'Bob', 'age': 30},
    {'name': 'Charlie', 'age': 20},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = users.where((u) => u['age'] > 21).toList();

    final sorted = List.from(filtered);
    sorted.sort((a, b) => a['age'].compareTo(b['age']));

    return ListView.builder(
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        final user = sorted[index];
        return ListTile(title: Text('${user['name']} (${user['age']})'));
      },
    );
  }
}

/* Dropdown Filter menu */
class DropdownFilterExample extends StatefulWidget {
  @override
  _DropdownFilterExampleState createState() => _DropdownFilterExampleState();
}

class _DropdownFilterExampleState extends State<DropdownFilterExample> {
  String selectedRole = 'All';

  final List<Map<String, String>> users = [
    {'name': 'Alice', 'role': 'Admin'},
    {'name': 'Bob', 'role': 'User'},
    {'name': 'Charlie', 'role': 'Admin'},
    {'name': 'David', 'role': 'Guest'},
  ];

  @override
  Widget build(BuildContext context) {
    final roles = ['All', 'Admin', 'User', 'Guest'];

    final filteredUsers =
        selectedRole == 'All'
            ? users
            : users.where((u) => u['role'] == selectedRole).toList();

    return Column(
      children: [
        DropdownButton<String>(
          value: selectedRole,
          items:
              roles.map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
          onChanged: (value) {
            setState(() => selectedRole = value!);
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(filteredUsers[index]['name']!),
                subtitle: Text(filteredUsers[index]['role']!),
              );
            },
          ),
        ),
      ],
    );
  }
}

/* Checkbox ListTile */
class CheckboxFilterExample extends StatefulWidget {
  @override
  _CheckboxFilterExampleState createState() => _CheckboxFilterExampleState();
}

class _CheckboxFilterExampleState extends State<CheckboxFilterExample> {
  bool showOnlyActive = false;

  final List<Map<String, dynamic>> users = [
    {'name': 'Alice', 'active': true},
    {'name': 'Bob', 'active': false},
    {'name': 'Charlie', 'active': true},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredUsers =
        showOnlyActive
            ? users.where((u) => u['active'] == true).toList()
            : users;

    return Column(
      children: [
        CheckboxListTile(
          title: Text('Show only active users'),
          value: showOnlyActive,
          onChanged: (value) => setState(() => showOnlyActive = value!),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final user = filteredUsers[index];
              return ListTile(
                title: Text(user['name']),
                trailing: Icon(
                  user['active'] ? Icons.check_circle : Icons.cancel,
                  color: user['active'] ? Colors.green : Colors.red,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/* PopUp Menu */
class PopupMenuFilterExample extends StatefulWidget {
  @override
  _PopupMenuFilterExampleState createState() => _PopupMenuFilterExampleState();
}

class _PopupMenuFilterExampleState extends State<PopupMenuFilterExample> {
  String sortOrder = 'asc';

  final List<String> items = ['Banana', 'Apple', 'Mango', 'Grapes'];

  @override
  Widget build(BuildContext context) {
    List<String> sortedItems = [...items];
    sortedItems.sort();
    if (sortOrder == 'desc') sortedItems = sortedItems.reversed.toList();

    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<String>(
            icon: Icon(Icons.filter_list),
            onSelected: (value) => setState(() => sortOrder = value),
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: 'asc', child: Text('Sort A-Z')),
                  PopupMenuItem(value: 'desc', child: Text('Sort Z-A')),
                ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sortedItems.length,
            itemBuilder:
                (context, index) => ListTile(title: Text(sortedItems[index])),
          ),
        ),
      ],
    );
  }
}

class SearchFilterExample extends StatefulWidget {
  @override
  _SearchFilterExampleState createState() => _SearchFilterExampleState();
}

class _SearchFilterExampleState extends State<SearchFilterExample> {
  final List<String> names = [
    'Alice',
    'Bob',
    'Charlie',
    'David',
    'Eve',
    'Frank',
    'Grace',
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredNames =
        names
            .where((name) => name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search names...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) => setState(() => query = value),
          ),
        ),
        Expanded(
          child:
              filteredNames.isEmpty
                  ? Center(child: Text('No matches found.'))
                  : ListView.builder(
                    itemCount: filteredNames.length,
                    itemBuilder:
                        (context, index) =>
                            ListTile(title: Text(filteredNames[index])),
                  ),
        ),
      ],
    );
  }
}

/* Search and Dropdown on One widget */

class CombinedSearchDropdownExample extends StatefulWidget {
  @override
  _CombinedSearchDropdownExampleState createState() =>
      _CombinedSearchDropdownExampleState();
}

class _CombinedSearchDropdownExampleState
    extends State<CombinedSearchDropdownExample> {
  final List<Map<String, String>> users = [
    {'name': 'Alice', 'role': 'Admin'},
    {'name': 'Bob', 'role': 'User'},
    {'name': 'Charlie', 'role': 'Admin'},
    {'name': 'David', 'role': 'Guest'},
    {'name': 'Eve', 'role': 'User'},
    {'name': 'Frank', 'role': 'Guest'},
  ];

  String searchQuery = '';
  String selectedRole = 'All';

  List<Map<String, String>> get filteredUsers {
    return users.where((user) {
      final matchesRole = selectedRole == 'All' || user['role'] == selectedRole;
      final matchesSearch = user['name']!.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesRole && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final roles = ['All', 'Admin', 'User', 'Guest'];

    return Scaffold(
      appBar: AppBar(title: Text('Search + Filter')),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),

          // Dropdown Filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: selectedRole,
              isExpanded: true,
              items:
                  roles
                      .map(
                        (role) =>
                            DropdownMenuItem(value: role, child: Text(role)),
                      )
                      .toList(),
              onChanged: (value) => setState(() => selectedRole = value!),
            ),
          ),

          // Filtered List
          Expanded(
            child:
                filteredUsers.isEmpty
                    ? Center(child: Text('No results found.'))
                    : ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return ListTile(
                          leading: Icon(Icons.person),
                          title: Text(user['name']!),
                          subtitle: Text(user['role']!),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

/* Integrating sort into the above code to see how all three work together */
class CombinedFilterSortExample extends StatefulWidget {
  @override
  _CombinedFilterSortExampleState createState() =>
      _CombinedFilterSortExampleState();
}

class _CombinedFilterSortExampleState extends State<CombinedFilterSortExample> {
  final List<Map<String, String>> users = [
    {'name': 'Alice', 'role': 'Admin'},
    {'name': 'Bob', 'role': 'User'},
    {'name': 'Charlie', 'role': 'Admin'},
    {'name': 'David', 'role': 'Guest'},
    {'name': 'Eve', 'role': 'User'},
    {'name': 'Frank', 'role': 'Guest'},
  ];

  String searchQuery = '';
  String selectedRole = 'All';
  String sortOrder = 'asc'; // or 'desc'

  List<Map<String, String>> get filteredAndSortedUsers {
    final List<Map<String, String>> filtered =
        users.where((user) {
          final matchesRole =
              selectedRole == 'All' || user['role'] == selectedRole;
          final matchesSearch = user['name']!.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
          return matchesRole && matchesSearch;
        }).toList();

    filtered.sort((a, b) {
      final nameA = a['name']!;
      final nameB = b['name']!;
      return sortOrder == 'asc'
          ? nameA.compareTo(nameB)
          : nameB.compareTo(nameA);
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final roles = ['All', 'Admin', 'User', 'Guest'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Filter + Search + Sort'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.sort),
            onSelected: (value) {
              setState(() => sortOrder = value);
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: 'asc', child: Text('Sort A-Z')),
                  PopupMenuItem(value: 'desc', child: Text('Sort Z-A')),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),

          // Dropdown Filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: selectedRole,
              isExpanded: true,
              items:
                  roles
                      .map(
                        (role) =>
                            DropdownMenuItem(value: role, child: Text(role)),
                      )
                      .toList(),
              onChanged: (value) => setState(() => selectedRole = value!),
            ),
          ),

          // Filtered + Sorted List
          Expanded(
            child:
                filteredAndSortedUsers.isEmpty
                    ? Center(child: Text('No results found.'))
                    : ListView.builder(
                      itemCount: filteredAndSortedUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredAndSortedUsers[index];
                        return ListTile(
                          leading: Icon(Icons.person),
                          title: Text(user['name']!),
                          subtitle: Text(user['role']!),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
