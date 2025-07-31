import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list_app/model/list.dart';

class ShoppingListTile extends StatelessWidget {
  final ShoppingItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ShoppingListTile({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(item.id!),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
            borderRadius: BorderRadius.circular(15), // Matched radius
          ),
          SlidableAction(
            onPressed: (_) {
              // --- UPDATED: Added confirmation dialog for delete ---
              _showDeleteConfirmationDialog(context, onDelete);
            },
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(15), // Matched radius
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        // --- UPDATED: Increased elevation and enhanced shadow ---
        elevation: 8.0,
        shadowColor: Colors.black.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Category Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconForCategory(item.category),
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Item Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.item,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Quantity: ${item.quantity}',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    if (item.priceRange != null && item.priceRange!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          'Expected Price Range: ${item.priceRange}',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // --- UPDATED: Added a subtle arrow icon as a visual hint ---
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_left_rounded,
                color: Colors.grey.withOpacity(0.5),
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- NEW: Helper method to show the delete confirmation dialog ---
  void _showDeleteConfirmationDialog(
    BuildContext context,
    VoidCallback onDelete,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Delete Item?'),
          content: Text(
            'Are you sure you want to delete "${item.item}"? This action cannot be undone.',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                onDelete();
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  IconData _getIconForCategory(String? category) {
    switch (category?.toLowerCase()) {
      case 'produce':
        return Icons.eco;
      case 'dairy':
        return Icons.icecream;
      case 'bakery':
        return Icons.bakery_dining;
      case 'meat':
        return Icons.set_meal;
      case 'pantry':
        return Icons.inventory_2;
      default:
        return Icons.shopping_cart;
    }
  }
}
