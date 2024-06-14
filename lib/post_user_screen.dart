import 'package:api_user_list_screen/simple.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddingUser extends StatefulWidget {
  const AddingUser({super.key});

  @override
  State<AddingUser> createState() => _AddingUserState();
}

class _AddingUserState extends State<AddingUser> {
  TextEditingController name = TextEditingController();
  TextEditingController job = TextEditingController();
  bool isLoader = false;

  Future<void> addUser() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      final response =
          await post(Uri.parse("https://reqres.in/api/users"), body: {
        "name": name.text,
        "job": job.text,
      });
      if (response.statusCode == 201) {
        setState(() {
          isLoader = false;
        });
        ElegantNotification.success(
          description: const Text("Data added successfully"),
        ).show(context);
        Navigator.pop(context);
      } else {
        ElegantNotification.error(
          description: const Text("error while submitting data"),
        ).show(context);
        setState(() {
          isLoader = false;
        });
      }
    }
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adding New User"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: isLoader
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Name";
                        }
                        return null;
                      },
                      controller: name,
                      decoration: const InputDecoration(
                        hintText: "Name",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Job";
                        }
                        return null;
                      },
                      controller: job,
                      decoration: const InputDecoration(
                        hintText: "job",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addUser();
                      },
                      child: const Text("Submit"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Apicall();
                            },
                          ),
                        );
                      },
                      child: const Text("Next"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
