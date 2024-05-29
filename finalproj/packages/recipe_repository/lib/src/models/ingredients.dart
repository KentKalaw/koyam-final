import '../entities/ingredients_entity.dart';

class Ingredients {
  String name;
  String quantity;

  Ingredients({
    required this.name,
    required this.quantity,
  });

  IngredientsEntity toEntity() {
return IngredientsEntity(
  name: name,
  quantity: quantity,
 
);
}

static Ingredients fromEntity(IngredientsEntity entity) {
return Ingredients(
  name: entity.name,
  quantity: entity.quantity,

    );
  }
}
