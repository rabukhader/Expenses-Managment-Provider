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

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        name: json["name"],
        total: json["total"],
        dueDate: json["dueDate"],
        imageUrl: json["imageUrl"],
        address: json["address"]
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "total": total,
        "dueDate": dueDate,
        "imageUrl": imageUrl,
        "address": address
      };
}
