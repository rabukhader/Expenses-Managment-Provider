class LocalExpenseChange {
  final String id;
  final Map<String, dynamic> changes;

  LocalExpenseChange({
    required this.id,
    required this.changes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'changes': changes,
    };
  }

  factory LocalExpenseChange.fromJson(Map<String, dynamic> json) {
    return LocalExpenseChange(
      id: json['id'],
      changes: json['changes'],
    );
  }
}
