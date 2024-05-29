import '../entities/entities.dart';

class MyUser {
  String userId;
  String email;
  String name;
  bool hasFavorites;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasFavorites,
  });

  static final empty = MyUser(
    userId: '',
     email: '',
      name: '',
       hasFavorites: false,
       );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      hasFavorites: hasFavorites,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      hasFavorites: entity.hasFavorites,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $hasFavorites';
  }
}