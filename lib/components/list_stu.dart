// ignore_for_file: unnecessary_const

import 'package:applcation_test/models/etudiant.dart';
import 'package:applcation_test/views/edit.dart';
import 'package:flutter/material.dart';

class ListStu extends StatelessWidget {
  const ListStu({super.key, required this.stu});

  final List<Student> stu;
  @override
  Widget build(BuildContext context) {
    return stu.isEmpty
        ? const Center(
            child: Text("Aucun étudiant enregistré"),
          )
        : ListView.separated(
            itemBuilder: ((context, index) => ListTile(
                  leading: Text(stu.elementAt(index).id.toString()),
                  title: Text(stu.elementAt(index).nom),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                                  title: const Text("About"),
                                  content: const Text(
                                      "Voulez-vous vraiment supprimer cet étudiant ?"),
                                ));
                      }),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Edit(stu: stu.elementAt(index)))),
                )),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: stu.length);
  }
}
