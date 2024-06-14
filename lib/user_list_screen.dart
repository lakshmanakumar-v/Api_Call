import 'dart:convert';

import 'package:api_user_list_screen/post_user_screen.dart';
import 'package:api_user_list_screen/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  List<UserModel> userData = [];
  bool isLoader = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final response = await get(Uri.parse('https://reqres.in/api/users?page=1'));
    print(response.body);
    setState(() {
      userData = (jsonDecode(response.body)['data'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
      isLoader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Users'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: isLoader
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: userData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    userData[index].avatar.toString()),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData[index].firstName.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    userData[index].email.toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    }),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return const AddingUser();
                  }),
                ),
              );
            },
            child: const Text(
              "+",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
