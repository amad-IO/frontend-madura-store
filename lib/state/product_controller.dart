import 'package:flutter/foundation.dart';
import '../data/models/product.dart';

class ProductController extends ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      name: 'Air hijau',
      price: 3000,
      stock: 20, // ✅
      rating: 4.8,
      imageUrl: 'https://picsum.photos/200/200?1',
      category: 'Minuman',
    ),
    Product(
      id: 'p2',
      name: 'Mie instan',
      price: 3500,
      stock: 20, // ✅
      rating: 4.8,
      imageUrl: 'https://picsum.photos/200/200?2',
      category: 'Makanan',
    ),
  ];

  List<Product> get items => List.unmodifiable(_items);

  void add(Product p) {
    _items.insert(0, p);
    notifyListeners();
  }

  // ✅ tambahkan update untuk edit produk
  void update(Product updated) {
    final i = _items.indexWhere((e) => e.id == updated.id);
    if (i != -1) {
      _items[i] = updated;
      notifyListeners();
    }
  }
}
