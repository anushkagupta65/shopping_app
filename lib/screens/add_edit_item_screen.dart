import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list_app/model/list.dart';
import 'package:shopping_list_app/services/api_service.dart';

class AddEditItemScreen extends StatefulWidget {
  final ShoppingItem? item;

  const AddEditItemScreen({super.key, this.item});

  @override
  State<AddEditItemScreen> createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();
  bool _isLoading = false;

  late TextEditingController _itemController;
  late TextEditingController _quantityController;
  late TextEditingController _categoryController;
  late TextEditingController _priceRangeController;

  bool get _isEditing => widget.item != null;

  @override
  void initState() {
    super.initState();
    _itemController = TextEditingController(text: widget.item?.item ?? '');
    _quantityController = TextEditingController(
      text: widget.item?.quantity ?? '',
    );
    _categoryController = TextEditingController(
      text: widget.item?.category ?? '',
    );
    _priceRangeController = TextEditingController(
      text: widget.item?.priceRange ?? '',
    );
  }

  @override
  void dispose() {
    _itemController.dispose();
    _quantityController.dispose();
    _categoryController.dispose();
    _priceRangeController.dispose();
    super.dispose();
  }

  Future<void> _saveItem() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final newItem = ShoppingItem(
        id: widget.item?.id,
        item: _itemController.text,
        quantity: _quantityController.text,
        category: _categoryController.text,
        priceRange: _priceRangeController.text,
      );

      try {
        if (_isEditing) {
          await _apiService.updateItem(newItem.id!, newItem);
        } else {
          await _apiService.addItem(newItem);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Item saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(true); // Return true to signal success
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving item: $e'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Item' : 'Add New Item'),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextFormField(
                controller: _itemController,
                labelText: 'Item Name',
                icon: Icons.label_important_outline,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter an item name' : null,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                controller: _quantityController,
                labelText: 'Quantity',
                icon: Icons.format_list_numbered,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter a quantity' : null,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                controller: _categoryController,
                labelText: 'Category (e.g., Produce, Dairy)',
                icon: Icons.category_outlined,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                controller: _priceRangeController,
                labelText: 'Price Range (e.g., \$5 - \$10)',
                icon: Icons.price_change_outlined,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveItem,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child:
                    _isLoading
                        ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                        : Text(
                          _isEditing ? 'Update Item' : 'Add Item',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        labelStyle: GoogleFonts.lato(),
      ),
    );
  }
}
