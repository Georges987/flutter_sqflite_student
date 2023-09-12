import 'package:applcation_test/provider/student_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paramètres")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("Vider la base"),
            subtitle:
                const Text("Supprimer toutes les entrées de la base de donnée"),
            leading: const Icon(Icons.delete),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("About"),
                        content: const Text(
                            "Voulez-vous vraiment supprimer toutes les entrées de la base de donnée ?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Annuler")),
                          TextButton(
                              onPressed: () {
                                StuProvider().deleteAll();
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: "Base de donnée vidée");
                              },
                              child: const Text("Supprimer"))
                        ],
                      ));
            },
          ),
          ListTile(
            title: const Text("Quitter"),
            subtitle: const Text("Quitter l'application"),
            leading: const Icon(Icons.exit_to_app),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("About"),
                        content: const Text(
                            "Voulez-vous vraiment quitter l'application ?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Annuler")),
                          TextButton(
                              onPressed: () {
                                SystemNavigator.pop();
                              },
                              child: const Text("Quitter"))
                        ],
                      ));
            },
          )
        ],
      ),
    );
  }
}
