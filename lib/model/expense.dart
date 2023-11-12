// ignore_for_file: public_member_api_docs, sort_constructors_first
class Expense {
  String name;
  int? total;
  String dueDate;

  Expense({
    required this.name,
    required this.total,
    required this.dueDate,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        name: json["name"],
        total: json["total"],
        dueDate: json["dueDate"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "total": total,
        "dueDate": dueDate,
      };
}
