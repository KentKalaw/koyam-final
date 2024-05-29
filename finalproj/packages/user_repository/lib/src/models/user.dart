import '../entities/entities.dart';

class MyUser {
  String userId;
  String email;
  String name;
  String picture;
  bool hasFavorites;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.picture,
    required this.hasFavorites,
  });

  static final empty = MyUser(
    userId: '',
     email: '',
      name: '',
      picture: '',
       hasFavorites: false,
       );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      picture: picture,
      hasFavorites: hasFavorites,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      picture: entity.picture,
      hasFavorites: entity.hasFavorites,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $picture, $hasFavorites';
  }
}