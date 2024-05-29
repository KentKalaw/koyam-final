import 'package:recipe_repository/src/models/models.dart';

class InstructionsEntity {
  String steps;

  InstructionsEntity({
    required this.steps,
  });

  Map<String, Object?> toDocument() {
    return {
      'steps': steps,
    };
  }

  static InstructionsEntity fromDocument(Map<String, dynamic> doc) {
    return InstructionsEntity(
      steps: doc['steps'],
    );
  }
}