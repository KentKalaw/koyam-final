import 'package:recipe_repository/src/models/models.dart';

class IngredientsEntity {
  String name;
  String quantity;

  IngredientsEntity({
    required this.name,
    required this.quantity,
  });

  Map<String, Object?> toDocument() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }

  static IngredientsEntity fromDocument(Map<String, dynamic> doc) {
    return IngredientsEntity(
      name: doc['name'],
      quantity: doc['quantity'],
    );
  }
}