import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({super.key, required this.control, required this.placeholder, required this.type});

  final TextEditingController control;
  final String placeholder;
  final TextInputType type;

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Ce champ est obligatoire";
    }

    if (type == TextInputType.number) {
      if (int.tryParse(value) == null) {
        return "Ce champ doit être un nombre";
      }
    }
    else if (type == TextInputType.emailAddress) {
      if (!value.contains("@")) {
        return "Ce champ doit être une adresse email";
      }
    }
    else if (type == TextInputType.phone) {
      if (value.length != 10) {
        return "Ce champ doit être un numéro de téléphone";
      }
    }
    else if (type == TextInputType.text) {
      if (value.length < 3) {
        return "Veuillez entrer au moins 3 caractères";
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: control,
      keyboardType: type,
      validator: validator,
      decoration: InputDecoration(
        label: Text(placeholder)
      ),
    );
  }
}
