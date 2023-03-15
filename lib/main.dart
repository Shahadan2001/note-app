// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:note_app/note_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: home(),
    );
  }
}

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note-App'),
        backgroundColor: Colors.brown[400],
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.calendar),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => Note_Screen()),
                ));
          });
        },
        child: Text('+'),
        elevation: 2,
      ),
      body: StreamBuilder(
        stream: fireStore.collection('task').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(0, 5), // shadow direction: bottom right
                      ),
                    ],
                  ),
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 15.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.grey,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        deleteTask(document.id);
                        print('pressed');
                      },
                      icon: Icon(CupertinoIcons.delete),
                    ),
                    title: Text(
                      document['taskName'],
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(document['taskDesc']),
                    isThreeLine: true,
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void deleteTask(id) {
    fireStore.collection('task').doc(id).delete();
    Fluttertoast.showToast(msg: 'Task deleted');
  }
}
