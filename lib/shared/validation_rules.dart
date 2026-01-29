/// Student Record Validation Rules and Best Practices

class ValidationRules {
  // Student Search Validation
  static String? validateSearchQuery(String? value) {
    // Search query is optional - can be empty or any string
    return null; // No validation needed
  }

  // Date Validation
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date is required';
    }

    // Check format YYYY-MM-DD
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(value)) {
      return 'Date must be in format YYYY-MM-DD';
    }

    // Check if date is valid
    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return 'Invalid date';
    }
  }

  // Para Validation
  static String? validatePara(String? value) {
    if (value == null || value.isEmpty) {
      return 'Para/Content is required';
    }

    if (value.length < 5) {
      return 'Para must be at least 5 characters';
    }

    if (value.length > 1000) {
      return 'Para must not exceed 1000 characters';
    }

    return null;
  }

  // Remarks Validation
  static String? validateRemarks(String? value) {
    if (value == null || value.isEmpty) {
      return 'Remarks are required';
    }

    if (value.length < 3) {
      return 'Remarks must be at least 3 characters';
    }

    if (value.length > 500) {
      return 'Remarks must not exceed 500 characters';
    }

    return null;
  }

  // Student Name Validation
  static String? validateStudentName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Student name is required';
    }

    if (value.length < 2) {
      return 'Student name must be at least 2 characters';
    }

    if (value.length > 100) {
      return 'Student name must not exceed 100 characters';
    }

    return null;
  }

  // GR Number Validation
  static String? validateGRNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'GR number is required';
    }

    if (value.length < 3) {
      return 'GR number must be at least 3 characters';
    }

    if (value.length > 20) {
      return 'GR number must not exceed 20 characters';
    }

    return null;
  }

  // Class Name Validation
  static String? validateClassName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Class name is required';
    }

    if (value.length > 50) {
      return 'Class name must not exceed 50 characters';
    }

    return null;
  }
}

/// Usage in Form:
///
/// TextFormField(
///   controller: dateController,
///   validator: (value) => ValidationRules.validateDate(value),
///   decoration: InputDecoration(labelText: 'Date'),
/// )
