class Medicine {
  final String? id;
  final String name;
  final String endDate;
  final String? verifyDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Medicine({
    this.id,
    required this.name,
    required this.endDate,
    this.verifyDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'],
      endDate: json['end_date'],
      verifyDate: json['verify_date'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'end_date': endDate,
    };
  }
}
