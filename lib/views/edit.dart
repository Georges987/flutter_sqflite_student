import 'package:applcation_test/components/input.dart';
import 'package:applcation_test/models/etudiant.dart';
import 'package:applcation_test/provider/student_provider.dart';
import 'package:applcation_test/views/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Edit extends StatefulWidget {
  const Edit({super.key, required this.stu});

  final Student stu;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController sexeController = TextEditingController();
  TextEditingController matriculeController = TextEditingController();
  TextEditingController telController = TextEditingController();
  DateTime birth = DateTime.fromMicrosecondsSinceEpoch(0);

  @override
  void initState() {
    nomController.text = widget.stu.nom;
    prenomController.text = widget.stu.prenom;
    sexeController.text = widget.stu.sexe;
    matriculeController.text = widget.stu.matricule;
    telController.text = widget.stu.telephone;
    birth = widget.stu.birth;
    super.initState();
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    sexeController.dispose();
    matriculeController.dispose();
    telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Modifier l'étudiant ${widget.stu.id.toString()}"),
          centerTitle: true,
          scrolledUnderElevation: 5,
        ),
        body: Form(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Input(
                    control: matriculeController,
                    placeholder: "Matricule de l'étudiant",
                    type: TextInputType.text
                  ),
                    
                const SizedBox(
                  height: 20,
                ),
                Input(control: nomController, placeholder: "Nom de l'étudiant", type: TextInputType.name),
                const SizedBox(
                  height: 20,
                ),
                Input(
                    control: prenomController,
                    placeholder: "Prénom de l'étudiant",
                    type: TextInputType.name    
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Sexe de l'étudiant"),
                DropdownButtonFormField(
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
                Input(
                    control: telController,
                    placeholder: "Telephone de l'étudiant",
                    type: TextInputType.number
                ),
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (matriculeController.text.isNotEmpty &&
                            nomController.text.isNotEmpty &&
                            prenomController.text.isNotEmpty &&
                            sexeController.text.isNotEmpty &&
                            telController.text.isNotEmpty) {
                          Student stu = Student(
                              widget.stu.id,
                              matriculeController.text,
                              nomController.text,
                              prenomController.text,
                              sexeController.text,
                              birth,
                              telController.text);
                          StuProvider().update(stu);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                          Fluttertoast.showToast(msg: "Etudiant modifié");
                        } else {
                          Fluttertoast.showToast(
                              msg: "Veuillez remplir tous les champs");
                        }
                      },
                      child: const Text("Modifier")),
                )
              ],
            ),
          )),
        ));
  }
}
