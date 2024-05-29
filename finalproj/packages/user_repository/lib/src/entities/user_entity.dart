import 'package:user_repository/src/models/models.dart';

class MyUserEntity {
  String userId;
  String email;
  String name;
  String picture;
  bool hasFavorites;

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.picture,
    required this.hasFavorites,
  });
  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'picture': picture,
      'hasFavorites': hasFavorites,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
       email: doc['email'],
        name: doc['name'],
         picture: doc['picture'],
         hasFavorites: doc['hasFavorites']
         );
  }
}