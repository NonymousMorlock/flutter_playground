import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool value = false;
  List<Map<String, dynamic>> listItems = [
    {
      "id": 1,
      "task": "Buy Tomatoes",
      "isCompleted": false,
    },
    {
      "id": 2,
      "task": "Buy Pototoes",
      "isCompleted": false,
    },
    {
      "id": 3,
      "task": "Buy Cucumber",
      "isCompleted": false,
    },
    {
      "id": 4,
      "task": "Buy Ice cream",
      "isCompleted": false,
    },
    {
      "id": 5,
      "task": "Buy Garlic",
      "isCompleted": false,
    },
    {
      "id": 6,
      "task": "Buy Chips",
      "isCompleted": false,
    },
    {
      "id": 7,
      "task": "Buy Beer",
      "isCompleted": false,
    },
    {
      "id": 7,
      "task": "Buy Chicken",
      "isCompleted": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Todo"),
        actions: const [
          Icon(Icons.dark_mode),
          Icon(Icons.light_mode),
          SizedBox(
            width: 20,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        icon: const Icon(Icons.add),
        label: const Text("Add Task"),
        onPressed: () {
          _showBottomSheet(context);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(
                    index.toString(),
                  ),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {},
                  child: Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: listItems[index]["isCompleted"],
                        onChanged: (value) {
                          setState(() {
                            listItems[index]["isCompleted"] = value;
                          });
                        },
                      ),
                      title: Text(listItems[index]["task"]),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_square),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Future _showBottomSheet(context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Container(
      height: 250,
      // margin: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Add Task",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  minimumSize: const Size(64, 64),
                ),
                onPressed: () {},
                icon: const Icon(Icons.add),
              )
            ],
          ),
        ],
      ),
    ),
  );
}