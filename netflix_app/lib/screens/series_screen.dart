import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_app/widgets/item_list.dart';

class SeriesScreen extends StatefulWidget {  
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  Future<List> getSeries() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.40:3000/getBooks'));

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Series list'),
      ),
      body: FutureBuilder<List>(
        future: getSeries(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error getting series: ${snapshot.error}');
          }
          return snapshot.hasData
              ? ItemList(
                  list: snapshot.data!,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
