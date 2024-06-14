import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Apicall extends StatefulWidget {
  const Apicall({super.key});

  @override
  State<Apicall> createState() => _ApicallState();
}

class _ApicallState extends State<Apicall> {
  List getData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response = await get(
      Uri.parse("https://jsonplaceholder.typicode.com/albums"),
    );
    print(response.body);
    setState(() {
      getData = (jsonDecode(response.body));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Call"),
      ),
      body: ListView.builder(
        itemCount: getData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(getData[index]['id'].toString()),
            subtitle: Text(getData[index]['title']),
          );
        },
      ),
    );
  }
}
