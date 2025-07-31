class ShoppingItem {
  final String? id; // Nullable for new items that don't have an ID yet
  final String item;
  final String quantity;
  final String? category;
  final String? priceRange;

  ShoppingItem({
    this.id,
    required this.item,
    required this.quantity,
    this.category,
    this.priceRange,
  });

  // Factory constructor to create a ShoppingItem from JSON
  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      id: json['_id'], // MongoDB uses _id
      item: json['item'],
      quantity: json['quantity'],
      category: json['category'],
      priceRange: json['priceRange'],
    );
  }

  // Method to convert a ShoppingItem instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'quantity': quantity,
      'category': category,
      'priceRange': priceRange,
    };
  }
}
