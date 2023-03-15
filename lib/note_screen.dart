import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Note_Screen extends StatefulWidget {
  Note_Screen({super.key});

  @override
  State<Note_Screen> createState() => _Note_ScreenState();
}

class _Note_ScreenState extends State<Note_Screen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController taskNameController = TextEditingController();
    final TextEditingController taskDescController = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Screen'),
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 3,
                  color: Colors.brown,
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(0, 5), // shadow direction: bottom right
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: taskNameController,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              hintText: 'Task',
                              hintStyle: const TextStyle(fontSize: 14),
                              icon: const Icon(CupertinoIcons.square_list,
                                  color: Colors.brown),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: taskDescController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              hintText: 'Description',
                              hintStyle: const TextStyle(fontSize: 14),
                              icon: const Icon(
                                  CupertinoIcons.bubble_left_bubble_right,
                                  color: Colors.brown),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                          ),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final String taskName = taskNameController.text;
                            final String taskDesc = taskDescController.text;
                            DocumentReference docRef = await FirebaseFirestore
                                .instance
                                .collection('task')
                                .add(
                              {
                                'taskName': taskName,
                                'taskDesc': taskDesc,
                              },
                            );
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
