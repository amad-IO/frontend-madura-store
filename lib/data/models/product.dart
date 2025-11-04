class Product {
  final String id;
  final String name;
  final int price;
  final int stock;           // ✅ tambahkan
  final double rating;
  final String imageUrl;
  final String? category;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,     // ✅ wajibkan di constructor
    required this.rating,
    required this.imageUrl,
    this.category,
  });

  Product copyWith({
    String? id,
    String? name,
    int? price,
    int? stock,
    double? rating,
    String? imageUrl,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }
}
