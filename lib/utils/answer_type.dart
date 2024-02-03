import 'package:flutter/material.dart';

class AnswerType {
  String label;
  final Color color;
  late void Function() onPressed;

  AnswerType(this.label, this.color);

  static final kYes = AnswerType('Yes', Colors.green.shade500);
  static final kNo = AnswerType('No', Colors.red.shade500);
}
