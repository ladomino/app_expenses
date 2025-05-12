/*

Used to create a menu (often shown on a button press) with a list of items.

The itemBuilder returns a list of PopupMenuEntry widgets (usually PopupMenuItem).

Called when the popup menu is opened.

PopupMenuButton<String>(
  onSelected: (value) {
    print('Selected: $value');
  },
  itemBuilder: (BuildContext context) => [
    PopupMenuItem<String>(
      value: 'Option 1',
      child: Text('Option 1'),
    ),
    PopupMenuItem<String>(
      value: 'Option 2',
      child: Text('Option 2'),
    ),
  ],
);

DropdownButton is used to let a user pick one value from a list of items. 
Each option is a DropdownMenuItem, and you provide those using the items list."

String selectedValue = 'One'; // Default value

DropdownButton<String>(
  value: selectedValue,
  onChanged: (String? newValue) {
    setState(() {
      selectedValue = newValue!;
    });
  },
  items: ['One', 'Two', 'Three'].map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList(),
)



Builder: You define a function that takes an index and returns a widget for that index.

ListView.builder(
  itemCount: 100,  // Number of items in the list
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('Item $index'),
    );
  },
)

Purpose: Efficiently creates a grid of items where the number of items may vary or be large.

Builder: A function that returns a widget for each index, similar to ListView.builder.

GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,  // Number of items per row
  ),
  itemCount: 20,  // Number of grid items
  itemBuilder: (context, index) {
    return Card(
      child: Center(child: Text('Grid Item $index')),
    );
  },
)

Purpose: To asynchronously load data and show loading, success, or error states.

Builder: You provide a callback that returns a widget based on the AsyncSnapshot (which contains the state of the Future).

FutureBuilder<String>(
  future: fetchData(),  // An async method that returns a Future<String>
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();  // Show loading spinner
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return Text('Data: ${snapshot.data}');
    }
  },
)

Purpose: To display and update data from a stream (e.g., WebSocket, Firestore).

Builder: Similar to FutureBuilder, but instead of waiting for a one-time result, it listens to a stream of data and rebuilds the UI with each new event in the stream.

StreamBuilder listens for updates from the streamOfNumbers() and rebuilds the widget with the new data as it comes in.

StreamBuilder<int>(
  stream: streamOfNumbers(),  // A stream of integers
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();  // Show loading spinner
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return Text('Stream Data: ${snapshot.data}');
    }
  },
)

Purpose: To efficiently rebuild widgets during an animation.

Builder: The builder takes the BuildContext and an Animation object, and it returns a widget based on the current animation state.

AnimatedBuilder allows you to wrap an animated widget and rebuild it only when the animation changes, which is efficient for performance

AnimatedBuilder(
  animation: animationController,  // An AnimationController
  builder: (context, child) {
    return Transform.rotate(
      angle: animationController.value * 2.0 * 3.14159,
      child: child,  // This is a child widget that doesn't rebuild
    );
  },
  child: Icon(Icons.rotate_right),  // Child widget stays static
)


Purpose: To create highly customizable scroll views with lazy loading.

Builder: Builders are used to generate the list or grid dynamically.

SliverChildBuilderDelegate is used to lazily build list items in a SliverList. It’s efficient because it builds only the visible items.

CustomScrollView(
  slivers: [
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(title: Text('Item $index'));
        },
        childCount: 50,  // Total number of items in the list
      ),
    ),
  ],
)

showDialog uses a builder function to lazily construct the dialog's content, allowing you to return different content based on the BuildContext.

showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Dialog Title'),
      content: Text('Dialog content goes here'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  },
);

Purpose: To display a modal bottom sheet (a sliding panel from the bottom) with dynamic content that you can define in the builder.

Builder: The builder function takes the BuildContext and allows you to return a widget that will be displayed inside the bottom sheet.

showModalBottomSheet(
  context: context,
  builder: (BuildContext context) {
    return Container(
      height: 200,
      color: Colors.blue,
      child: Center(
        child: Text('This is a modal bottom sheet!'),
      ),
    );
  },
);


Provider Package

Purpose: Select and rebuild only parts of your widget tree that depend on a specific part of your state or model, not the whole model.

Builder: The builder function takes the context and the selected value and returns a widget based on that.

he Selector widget is useful for rebuilding a widget tree only when a specific part of your model changes, which is especially useful for state management. It takes a builder function to rebuild parts of the UI based on selected state.

The selector function allows you to extract only the part of your model that you care about, and the builder function only rebuilds the widget when that part of the model changes.

Selector<MyModel, String>(
  selector: (context, model) => model.someString,  // Select a specific part of the model
  builder: (context, selectedValue, child) {
    return Text('Selected value: $selectedValue');
  },
)

Purpose: To listen to a specific model or state and rebuild only the widgets inside the builder when that model changes.

Builder: The builder function takes the BuildContext and the model (or value) as parameters. The widget inside the builder will be rebuilt when the value changes.

Consumer listens to changes in MyModel (in this case, model.someValue).

builder is called every time the model changes, and it rebuilds the widget that depends on that model.

**You can also pass an optional child to the Consumer to avoid rebuilding widgets that don't depend on the model.

Consumer<MyModel>(
  builder: (context, model, child) {
    return Text('Value from model: ${model.someValue}');
  },
)


*/


