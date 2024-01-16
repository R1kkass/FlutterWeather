import './util/todo_tole.dart';
import './util/search_tole.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

void close(context) {
  Navigator.of(context).pop();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Погода',
      routes: {
        '/': (context) => const MyHomePage(title: 'Погода'),
        '/details': (context) => const SearchPage(title: 'Поиск'),
      },
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
          primarySwatch: Colors.green,
          textTheme: const TextTheme(
              bodyMedium: TextStyle(
                  color: Color.fromARGB(255, 211, 18, 0), fontSize: 30))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int myCount = 0;

  void myCountIncremet() {
    Navigator.of(context).pushNamed("/details");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const ListCities(),
      floatingActionButton: FloatingActionButton(
        onPressed: myCountIncremet,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const SearchTole(),
    );
  }
}
