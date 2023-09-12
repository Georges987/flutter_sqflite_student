import 'package:applcation_test/components/input.dart';
import 'package:applcation_test/provider/student_provider.dart';
import 'package:applcation_test/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddStu extends StatefulWidget {
  const AddStu({super.key});

  @override
  State<AddStu> createState() => _AddStuState();
}

class _AddStuState extends State<AddStu> {
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController sexeController = TextEditingController();
  TextEditingController matriculeController = TextEditingController();
  TextEditingController telController = TextEditingController();
  DateTime birth = DateTime.fromMicrosecondsSinceEpoch(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter un nouvel étudiant"),
      ),
        body: ListView(
        children: [
          Input(
              control: matriculeController,
              placeholder: "Matricule de l'étudiant", type: TextInputType.text,),
          const SizedBox(
            height: 10,
          ),
          Input(control: nomController, placeholder: "Nom de l'étudiant", type: TextInputType.name),
          const SizedBox(
            height: 10,
          ),
          Input(control: prenomController, placeholder: "Prénom de l'étudiant", type: TextInputType.name),
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField(
              decoration: const InputDecoration(
                label: Text("Sexe de l'étudiant")
              ),
              onSaved: (newValue) {
                (value) => setState(() {
                      sexeController.text = value!;
                    });
              },
              items: const [
                DropdownMenuItem(
                  value: "Masculin",
                  child: Text("Masculin"),
                ),
                DropdownMenuItem(
                  value: "Féminin",
                  child: Text("Féminin"),
                ),
                DropdownMenuItem(
                  value: "Autre",
                  child: Text("Autre"),
                ),
              ],
              onChanged: (value) => setState(() {
                    sexeController.text = value!;
                  })),
          const SizedBox(
            height: 20,
          ),
          Input(control: telController, placeholder: "Telephone de l'étudiant", type: TextInputType.number),
          const SizedBox(
            height: 30,
          ),
          const Text("Date de naissance"),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: birth,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now());
                if (picked != null && picked != birth) {
                  setState(() {
                    birth = picked;
                  });
                }
              },
              child: Text(
                "${birth.day}/${birth.month}/${birth.year}",
                style: const TextStyle(color: Colors.black),
              )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                if (matriculeController.text.isNotEmpty &&
                    nomController.text.isNotEmpty &&
                    prenomController.text.isNotEmpty &&
                    sexeController.text.isNotEmpty &&
                    telController.text.isNotEmpty &&
                    birth != DateTime.fromMicrosecondsSinceEpoch(0)) {
                  var base = StuProvider().get();
                  base.then((value) => value.insert("students", {
                        "matricule": matriculeController.text,
                        "nom": nomController.text,
                        "prenom": prenomController.text,
                        "sexe": sexeController.text,
                        "birth": birth.millisecondsSinceEpoch,
                        "telephone": telController.text,
                      }).then((value) {
                        if (value > 0) {
                          Fluttertoast.showToast(
                              msg: "L'étudiant a été ajouté avec succès",
                              backgroundColor: Colors.green,
                              textColor: Colors.white);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const Home()),
                              (route) => false);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Une erreur est survenue",
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
                        }
                      }));
                } else {
                  Fluttertoast.showToast(
                      msg: "Veuillez remplir tous les champs",
                      backgroundColor: Colors.red,
                      textColor: Colors.white);
                }
              },
              child: const Text("Ajouter l'étudiant"))
        ],
      ),
    );
  }
}
