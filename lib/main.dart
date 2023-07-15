import 'package:flutter/material.dart';
import 'dart:math';

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
        fontFamily: 'Gaegu',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MemoListPage(title: 'Things to do'),
      },
    );
  }
}

class MemoListPage extends StatefulWidget {
  const MemoListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MemoListPage> createState() => _MemoListPageState();
}

class Memo {
  String content;
  Color color;

  Memo(this.content, this.color);
}

class _MemoListPageState extends State<MemoListPage> {
  List<Memo> memos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: memos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return Card(
            color: memos[index].color,
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                        child: Text(
                          memos[index].content, 
                          style: TextStyle(fontSize: 22), 
                          textAlign: TextAlign.center,
                        )
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        memos.removeAt(index);
                      });
                      
                    }, 
                    icon: Icon(Icons.close),
                    alignment: Alignment.topRight,
                  ),
                ),
              ]
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addMemo(context);
        },
        backgroundColor: Colors.blue[700],
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _selectRandomColor() {
    List<Color> colors = [Colors.red[50]!, Colors.orange[50]!, Colors.yellow[50]!, Colors.green[50]!, Colors.blue[50]!, Colors.purple[50]!];

    Random random = Random();

    int randomIndex = random.nextInt(colors.length);

    Color randomColor = colors[randomIndex];

    return randomColor;
  }

  void _addMemo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String newMemo = '';
        return AlertDialog(
          title: const Text('What do you need to do?'),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              newMemo = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Memo memo = Memo(newMemo, _selectRandomColor());

                setState(() {
                  memos.add(memo);
                });

                Navigator.pop(context);
              },
              child: const Text('Add', style: TextStyle(fontSize: 24),),
            ),
          ],
        );
      },
    );
  }
}