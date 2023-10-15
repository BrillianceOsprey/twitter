// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String profilePicture;
  String email;
  String bio;
  String coverImage;
  UserModel({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.email,
    required this.bio,
    required this.coverImage,
  });

  // UserModel(
  //     {this.id,
  //     this.name,
  //     this.profilePicture,
  //     this.email,
  //     this.bio,
  //     this.coverImage});

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel(
      id: doc.id,
      name: doc['name'],
      email: doc['email'],
      profilePicture: doc['profilePicture'],
      bio: doc['bio'],
      coverImage: doc['coverImage'],
    );
  }
  factory UserModel.fromSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      id: snapshot.id,
      name: data['name'],
      email: data['email'],
      profilePicture: data['profilePicture'],
      bio: data['bio'],
      coverImage: data['coverImage'],
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? profilePicture,
    String? email,
    String? bio,
    String? coverImage,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      coverImage: coverImage ?? this.coverImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'profilePicture': profilePicture,
      'email': email,
      'bio': bio,
      'coverImage': coverImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      profilePicture: map['profilePicture'] as String,
      email: map['email'] as String,
      bio: map['bio'] as String,
      coverImage: map['coverImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, profilePicture: $profilePicture, email: $email, bio: $bio, coverImage: $coverImage)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.profilePicture == profilePicture &&
        other.email == email &&
        other.bio == bio &&
        other.coverImage == coverImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        profilePicture.hashCode ^
        email.hashCode ^
        bio.hashCode ^
        coverImage.hashCode;
  }
}
