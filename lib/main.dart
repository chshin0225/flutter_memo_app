import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MemoListPage(title: 'My Memos'),
        '/create': (context) => const MemoCreatePage(title: 'Create Memo'),
        '/detail': (context) => const MemoDetailPage(title: 'Memo'),
      },
    );
  }
}

class MemoListPage extends StatefulWidget {
  const MemoListPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MemoListPage> createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  List<String> memos = [];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: memos.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blue[50],
            child: ListTile(
              title: Text(memos[index], style: TextStyle(fontSize: 22),),
            ),
          );
        },
      ),
      // body: ListView(
      //   padding: const EdgeInsets.all(8),
      //   children: <Widget>[
      //     Card(
      //       color: Colors.blue[50],
      //       child: const ListTile(
      //         title: Text('item 1', style: TextStyle(fontSize: 22),),
      //         subtitle: Text('item 1 content'),
      //         trailing: Icon(Icons.more_vert),
      //       ),
      //     ),
      //     Card(
      //       color: Colors.blue[100],
      //       child: const ListTile(
      //         title: Text('item 2', style: TextStyle(fontSize: 22),),
      //         subtitle: Text('item 2 content'),
      //         trailing: Icon(Icons.more_vert),
      //       ),
      //     ),
      //     Card(
      //       color: Colors.blue[200],
      //       child: const ListTile(
      //         title: Text('item 3', style: TextStyle(fontSize: 22),),
      //         subtitle: Text('item 3 content'),
      //         trailing: Icon(Icons.more_vert),
      //       ),
      //     ),
      //     Card(
      //       color: Colors.blue[300],
      //       child: const ListTile(
      //         title: Text('item 4', style: TextStyle(fontSize: 22),),
      //         subtitle: Text('item 4 content'),
      //         trailing: Icon(Icons.more_vert),
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, '/create');
          _addMemo(context);
        },
        backgroundColor: Colors.blue[700],
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addMemo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String newMemo = '';
        return AlertDialog(
          title: const Text('Add Memo'),
          content: TextField(
            onChanged: (value) {
              newMemo = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  memos.add(newMemo);
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class MemoDetailPage extends StatefulWidget {
  const MemoDetailPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MemoDetailPage> createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
    );
  }
}

class MemoCreatePage extends StatefulWidget {
  const MemoCreatePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MemoCreatePage> createState() => _MemoCreatePageState();
}

class _MemoCreatePageState extends State<MemoCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Content',
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //   },
            //   child: Text('create memo'),
            // ),
          ],
        ),
      ),
      
    );
  }
}