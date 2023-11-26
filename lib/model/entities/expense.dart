class Expense {
  String name;
  int? total;
  String dueDate;
  String imageUrl;
  String address;

  Expense({
    required this.name,
    required this.total,
    required this.dueDate,
    required this.imageUrl,
    required this.address
  });

  factory Expense.fromMap(Map<String, dynamic> map) => Expense(
        name: map["name"],
        total: map["total"],
        dueDate: map["dueDate"],
        imageUrl: map["imageUrl"],
        address: map["address"]
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "total": total,
        "dueDate": dueDate,
        "imageUrl": imageUrl,
        "address": address
      };
}
