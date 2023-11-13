abstract class Validator {
  String? validate(String? value);
}

abstract class NameValidator {
  String? validateName(String? value);
}

abstract class TotalValidator {
  String? validateTotal(String? value);
}

class AddEditExpenseValidator
    implements Validator, NameValidator, TotalValidator {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'This Field is Required.';
    }
    return null;
  }

  @override
  String? validateTotal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value.';
    }
    final RegExp numberRegex = RegExp(r'^\d+$');
    if (!numberRegex.hasMatch(value)) {
      return 'Please enter a valid number.';
    }
    return null;
  }

  @override
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a value.';
    }
    final RegExp stringRegex = RegExp(r'^[a-zA-Z]+$');
    if (!stringRegex.hasMatch(value)) {
      return 'Please enter a valid string.';
    }
    return null;
  }
}
