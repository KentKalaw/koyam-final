import '../entities/instructions_entity.dart';

class Instructions {
  String steps;

  Instructions({required this.steps});

  static final empty = Instructions(steps: '');

  InstructionsEntity toEntity() {
    return InstructionsEntity(
      steps: steps,
    );
  }

  static Instructions fromEntity(InstructionsEntity entity) {
    return Instructions(
      steps: entity.steps,
    );
  }

 
}