import 'package:flutter/foundation.dart';
import '../data/models/product.dart';

class ProductController extends ChangeNotifier {
  final List<Product> _items = [
    Product(id: 'p1', name: 'Air hijau ', price: 3000, rating: 4.8, imageUrl: 'https://picsum.photos/200/200?1', category: 'Minuman'),
    Product(id: 'p2', name: 'Mie instan',  price: 3500, rating: 4.8, imageUrl: 'https://picsum.photos/200/200?2', category: 'Makanan'),
  ];

  List<Product> get items => List.unmodifiable(_items);

  void add(Product p) {
    _items.insert(0, p);
    notifyListeners();
  }
}
