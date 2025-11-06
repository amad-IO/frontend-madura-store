class Product {
  final int id;                // Backend biasanya pakai int untuk ID
  final String name;
  final int price;
  final int stock;
  final String unit;           // Misalnya: pcs, bungkus, botol
  final String? imageUrl;      // Optional (bisa null)
  final String? category;      // Optional (kategori produk)

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.unit,
    this.imageUrl,
    this.category,
  });

  /// 🧩 Convert dari JSON (response backend → Flutter model)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
      unit: json['unit'] ?? '',
      imageUrl: json['imageUrl'],
      category: json['category'],
    );
  }

  get rating => null;

  /// 🚀 Convert ke JSON (Flutter model → kirim ke backend)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'unit': unit,
      'imageUrl': imageUrl,
      'category': category,
    };
  }

  /// 🔁 Bikin salinan objek Product (berguna untuk update data)
  Product copyWith({
    int? id,
    String? name,
    int? price,
    int? stock,
    String? unit,
    String? imageUrl,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      unit: unit ?? this.unit,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, stock: $stock, unit: $unit)';
  }
}
