import 'package:user_repository/src/models/models.dart';

class MyUserEntity {
  String userId;
  String email;
  String name;
  bool hasFavorites;

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasFavorites,
  });
  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'hasFavorites': hasFavorites,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
       email: doc['email'],
        name: doc['name'],
         hasFavorites: doc['hasFavorites']
         );
  }
}