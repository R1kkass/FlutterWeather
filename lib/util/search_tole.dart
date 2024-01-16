import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter_application_1/main.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class City {
  List cities;

  City(this.cities);
}

class CityAdapter extends TypeAdapter<City> {
  @override
  final typeId = 0;

  @override
  City read(BinaryReader reader) {
    return City(reader.read());
  }

  @override
  void write(BinaryWriter writer, City obj) {
    writer.write(obj.cities);
  }
}

Future<Map<String, dynamic>> getHttp(value) async {
  try {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/find?q=${value}&units=metric&appid=70e1ed322b02acbc57d443dd91065f3e&lang=ru'));
    Map<String, dynamic> data = json.decode(response.body);
    return {"message": data["message"], "list": data["list"]};
  } catch (error, stacktrace) {
    throw Exception("Exception occured: $error stackTrace: $stacktrace");
  }
}

class SearchTole extends StatefulWidget {
  const SearchTole({super.key});

  @override
  State<SearchTole> createState() => _SearchTole();
}

class _SearchTole extends State<SearchTole> {
  Map<String, dynamic> cities = {};
  List listCities = [];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        autofocus: true,
        onSubmitted: (String value) async {
          var a = await getHttp(value);

          setState(() {
            cities = a;
            listCities = a["list"];
          });
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Введите город',
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: listCities.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Container(
                  child: Column(
                children: [
                  ListTile(
                    leading: Image.network(
                        "https://openweathermap.org/img/wn/${listCities[index]["weather"]?[0]?["icon"].toString()}@2x.png"),
                    title: Text(listCities[index]?["name"] != null
                        ? listCities[index]["name"]
                        : ""),
                    subtitle: Text(listCities[index]?["main"]["temp"] != null
                        ? "${listCities[index]["main"]["temp"].round().toString()} °C"
                        : ""),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('ДОБАВИТЬ'),
                        onPressed: () async {
                          Hive.registerAdapter(CityAdapter());
                          var stringBox =
                              await Hive.openBox<City>('citiesList');
                          var citiesList =
                              stringBox.get("city");
                              citiesList?.cities.add(listCities[index]);
                          stringBox.put("city", City(citiesList?.cities ?? []));
                        },
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
    ]);
  }
}
