// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:applcation_test/components/list_stu.dart';
import 'package:applcation_test/models/etudiant.dart';
import 'package:applcation_test/provider/student_provider.dart';
import 'package:applcation_test/views/add.dart';
import 'package:applcation_test/views/setting_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Student> _stu = [];

  void getStudent() {
    var base = StuProvider().get();

    base.then((value) =>
        value.query("students").then((value) => value.forEach((element) {
              setState(() {
                _stu.add(Student(
                  element['id'] as int,
                  element['matricule'] as String,
                  element['nom'] as String,
                  element['prenom'] as String,
                  element['sexe'] as String,
                  DateTime.fromMillisecondsSinceEpoch(element['birth'] as int),
                  element['telephone'] as String,
                ));
              });
            })));
  }

  @override
  void initState() {
    super.initState();
    getStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des étudiants"),
        leading: const Icon(Icons.home),
        actions: [
          IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingPage()));
          }, icon: const Icon(Icons.settings))
        ],
      ),
      
      body: Container(
        margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListStu(stu: _stu),
          ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddStu())),
          child: const Icon(Icons.add)),
    );
  }
}
