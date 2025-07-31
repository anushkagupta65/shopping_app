import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list_app/model/list.dart';
import '../services/api_service.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/error_display_widget.dart';
import '../widgets/shopping_list_tile.dart';
import 'add_edit_item_screen.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<ShoppingItem>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() {
    setState(() {
      _itemsFuture = _apiService.fetchItems();
    });
  }

  void _navigateToAddEditScreen({ShoppingItem? item}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditItemScreen(item: item)),
    );

    if (result == true) {
      _loadItems(); // Refresh the list if an item was added/edited
    }
  }

  void _deleteItem(String id) async {
    try {
      await _apiService.deleteItem(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item deleted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      _loadItems(); // Refresh list after deleting
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete item: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Shopping List',
          style: GoogleFonts.pacifico(fontSize: 28, color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Colors.tealAccent.shade400,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _loadItems(),
        child: FutureBuilder<List<ShoppingItem>>(
          future: _itemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return ErrorDisplayWidget(
                message: snapshot.error.toString(),
                onRetry: _loadItems,
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const EmptyListWidget();
            }

            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ShoppingListTile(
                  item: item,
                  onEdit: () => _navigateToAddEditScreen(item: item),
                  onDelete: () => _deleteItem(item.id!),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEditScreen(),
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
