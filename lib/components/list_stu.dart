// ignore_for_file: unnecessary_const

import 'package:applcation_test/models/etudiant.dart';
import 'package:applcation_test/provider/student_provider.dart';
import 'package:applcation_test/views/edit.dart';
import 'package:applcation_test/views/home.dart';
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
            padding: const EdgeInsets.all(10),
            itemBuilder: ((context, index) => ListTile(
                  leading: Text((index + 1).toString()),
                  title: Text(stu.elementAt(index).nom),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("About"),
                                  content: const Text(
                                      "Voulez-vous vraiment supprimer cet étudiant ?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Annuler")),
                                    TextButton(
                                        onPressed: () {
                                          StuProvider()
                                              .delete(stu.elementAt(index).id);
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Home(),
                                                  ),
                                                  (route) => false);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  dismissDirection: DismissDirection.horizontal,
                                                  closeIconColor: Colors.white,
                                                  showCloseIcon: true,
                                                  content: Text(
                                                      "Etudiant ${stu.elementAt(index).id} supprimé")));
                                        },
                                        child: const Text("Supprimer"))
                                  ],
                                ));
                      }),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Edit(stu: stu.elementAt(index)))),
                )),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: stu.length);
  }
}
