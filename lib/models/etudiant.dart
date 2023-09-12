// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Student {
  int id;
  String matricule;
  String nom;
  String prenom;
  String sexe;
  DateTime birth;
  String telephone;

  Student(
    this.id,
    this.matricule,
    this.nom,
    this.prenom,
    this.sexe,
    this.birth,
    this.telephone
  );

  Student copyWith({
    int? id,
    String? matricule,
    String? nom,
    String? prenom,
    String? sexe,
    DateTime? birth,
    String? telephone,
  }) {
    return Student(
      id ?? this.id,
      matricule ?? this.matricule,
      nom ?? this.nom,
      prenom ?? this.prenom,
      sexe ?? this.sexe,
      birth ?? this.birth,
      telephone ?? this.telephone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'matricule': matricule,
      'nom': nom,
      'prenom': prenom,
      'sexe': sexe,
      'birth': birth.millisecondsSinceEpoch,
      'telephone': telephone,
    };
  }

  factory Student.fromMap(Map<dynamic, dynamic> map) {
    return Student(
      map['id'] as int,
      map['matricule'] as String,
      map['nom'] as String,
      map['prenom'] as String,
      map['sexe'] as String,
      DateTime.fromMillisecondsSinceEpoch(map['birth'] as int),
      map['telephone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(id: $id, matricule: $matricule, nom: $nom, prenom: $prenom, sexe: $sexe, birth: $birth, telephone: $telephone)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.matricule == matricule &&
      other.nom == nom &&
      other.prenom == prenom &&
      other.sexe == sexe &&
      other.birth == birth &&
      other.telephone == telephone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      matricule.hashCode ^
      nom.hashCode ^
      prenom.hashCode ^
      sexe.hashCode ^
      birth.hashCode ^
      telephone.hashCode;
  }
}
