import 'package:shopping_list_app/model/list.dart';

class ApiService {
  // static const String _baseUrl = "http://10.0.2.2:3000/api/list";

  // --- READ: Fetch all shopping items ---
  Future<List<ShoppingItem>> fetchItems() async {
    // ** REPLACE THIS WITH YOUR API CALL **
    // Example:
    // final response = await http.get(Uri.parse(_baseUrl));
    // if (response.statusCode == 200) {
    //   List<dynamic> body = jsonDecode(response.body);
    //   List<ShoppingItem> items = body.map((dynamic item) => ShoppingItem.fromJson(item)).toList();
    //   return items;
    // } else {
    //   throw Exception('Failed to load shopping items');
    // }

    // Placeholder data for UI development:
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    // To test an empty list, return [];
    // To test an error, uncomment the line below:
    // throw Exception('Failed to connect to the server');
    return [
      ShoppingItem(
        id: '1',
        item: 'Organic Avocados',
        quantity: '2',
        category: 'Produce',
        priceRange: '\$3 - \$5',
      ),
      ShoppingItem(
        id: '2',
        item: 'Sourdough Bread',
        quantity: '1 loaf',
        category: 'Bakery',
        priceRange: '\$4 - \$6',
      ),
      ShoppingItem(
        id: '3',
        item: 'Almond Milk',
        quantity: '1/2 gallon',
        category: 'Dairy',
        priceRange: '\$3 - \$4',
      ),
    ];
  }

  // --- CREATE: Add a new shopping item ---
  Future<ShoppingItem> addItem(ShoppingItem item) async {
    // ** REPLACE THIS WITH YOUR API CALL **
    // Example:
    // final response = await http.post(
    //   Uri.parse(_baseUrl),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(item.toJson()),
    // );
    // if (response.statusCode == 201) {
    //   return ShoppingItem.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to add item.');
    // }

    // Placeholder:
    await Future.delayed(const Duration(seconds: 1));
    return item.copyWith(
      id: DateTime.now().toString(),
    ); // Simulate getting an ID back
  }

  // --- UPDATE: Update an existing item ---
  Future<ShoppingItem> updateItem(String id, ShoppingItem item) async {
    // ** REPLACE THIS WITH YOUR API CALL **
    // Example:
    // final response = await http.put(
    //   Uri.parse('$_baseUrl/$id'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(item.toJson()),
    // );
    // if (response.statusCode == 200) {
    //   return ShoppingItem.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to update item.');
    // }

    // Placeholder:
    await Future.delayed(const Duration(seconds: 1));
    return item;
  }

  // --- DELETE: Delete an item ---
  Future<void> deleteItem(String id) async {
    // ** REPLACE THIS WITH YOUR API CALL **
    // Example:
    // final response = await http.delete(Uri.parse('$_baseUrl/$id'));
    // if (response.statusCode != 200 && response.statusCode != 204) {
    //   throw Exception('Failed to delete item.');
    // }

    // Placeholder:
    await Future.delayed(const Duration(milliseconds: 500));
    return;
  }
}

// Helper extension to simulate database ID assignment
extension ShoppingItemCopyWith on ShoppingItem {
  ShoppingItem copyWith({String? id}) {
    return ShoppingItem(
      id: id ?? this.id,
      item: item,
      quantity: quantity,
      category: category,
      priceRange: priceRange,
    );
  }
}
