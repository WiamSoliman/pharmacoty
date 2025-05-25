class Product {
  final BigInt medicineId;
  final String name;
  final String manufacturer;
  final String activeIngredients;
  final String dosage;
  final String formulation;
  final DateTime registrationDate;
  final bool isActive;

  Product({
    required this.medicineId,
    required this.name,
    required this.manufacturer,
    required this.activeIngredients,
    required this.dosage,
    required this.formulation,
    required this.registrationDate,
    required this.isActive,
  });

  factory Product.fromFirestore(String id, Map<String, dynamic> json) {
    return Product(
      medicineId: BigInt.tryParse(json['medicineId'].toString()) ?? BigInt.zero,
      name: json['name'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      activeIngredients: json['activeIngredients'] ?? '',
      dosage: json['dosage'] ?? '',
      formulation: json['formulation'] ?? '',
      registrationDate: DateTime.tryParse(json['registrationDate'].toString()) ?? DateTime.now(),
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'medicineId': medicineId.toString(),
      'name': name,
      'manufacturer': manufacturer,
      'activeIngredients': activeIngredients,
      'dosage': dosage,
      'formulation': formulation,
      'registrationDate': registrationDate.toIso8601String(),
      'isActive': isActive,
    };
  }
}
