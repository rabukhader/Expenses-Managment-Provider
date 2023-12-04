import 'package:flutter/material.dart';
import '../../model/entities/expense_entity.dart';

abstract class CustomButton {
  final dynamic onPressed;
  final Expense data;
  final String id;
  final String label;
  final IconData icon;

  CustomButton({
    required this.data,
    required this.id,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  Widget build(BuildContext context);
}
