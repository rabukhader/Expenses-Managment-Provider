class LocalChangesModel {
  LocalChangesModel._();
    static final LocalChangesModel _instance = LocalChangesModel._();
    static LocalChangesModel get instance => _instance;

    List<LocalExpenseChange> listOfLocalChanges = [];
}

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
