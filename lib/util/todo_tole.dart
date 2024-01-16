import "package:flutter/material.dart";
import 'package:flutter_application_1/util/search_tole.dart';
import 'package:hive/hive.dart';

class ListCities extends StatefulWidget {
  const ListCities({super.key});

  @override
  State<ListCities> createState() => _ListCities();
}

void loadCities() async {
  print(1);

  var stringBox = await Hive.openBox<City>('citiesList');
  var a = stringBox.get('cities');
  print('2');

}

class _ListCities extends State<ListCities> {
  List<String> users = <String>["Tom", "Alice", "Bob", "Sam", "Kate"];
  @override
  // var stringBox = await Hive.openBox<String>('name_of_the_box');
  void initState() {
    loadCities();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Container(
                    child: Column(
                  children: [
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('The Enchanted Nightingale'),
                      subtitle:
                          Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('BUY TICKETS'),
                          onPressed: () {/* ... */},
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('LISTEN'),
                          onPressed: () {/* ... */},
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                )),
              );
            },
          ),
        ),
      ],
    );
  }
}
