import 'dart:io';
import 'dart:typed_data';

import 'package:ecopos/data/bloc/bloc/product/product_bloc.dart';
import 'package:ecopos/pages/category/datasource/category_remote_datasouce.dart';
import 'package:ecopos/pages/product/models/product_response_model.dart' as product_model;
import 'package:ecopos/pages/product/models/product_response_model.dart';
import 'package:flutter/foundation.dart'; // untuk kIsWeb
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProductPage extends StatefulWidget {
  final ProductElement product;

  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _nameController;
  late TextEditingController _initialPriceController;
  late TextEditingController _sellingPriceController;
  late TextEditingController _stockController;
  late TextEditingController _unitController;

  bool _isNonStock = false;
  String _selectedCategoryId = '';
  XFile? _pickedImage;
  Uint8List? _imageBytes;

  List<product_model.Category> _categories = [];
  bool _isLoadingCategory = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name ?? '');
    _initialPriceController =
        TextEditingController(text: widget.product.initialPrice);
    _sellingPriceController =
        TextEditingController(text: widget.product.sellingPrice);
    _stockController =
        TextEditingController(text: widget.product.stock.toString());
    _unitController = TextEditingController(text: widget.product.unit ?? '');
    _isNonStock = widget.product.isNonStock ?? false;
    _selectedCategoryId = widget.product.categoryId ?? '';

    _fetchCategories();
  }

  void _fetchCategories() async {
    try {
      final data = await CategoryRemoteDatasource().fetchCategories();
      setState(() {
        _categories = data;
        _isLoadingCategory = false;

        if (_selectedCategoryId.isEmpty && _categories.isNotEmpty) {
          _selectedCategoryId = _categories[0].id!;
        }
      });
    } catch (e) {
      setState(() => _isLoadingCategory = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load category')),
      );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        _imageBytes = await pickedFile.readAsBytes();
      } else {
        _imageBytes = await File(pickedFile.path).readAsBytes();
      }
      setState(() {
        _pickedImage = pickedFile;
      });
    }
  }

  void _submit() {
    http.MultipartFile? image;
    if (_pickedImage != null) {
      image = http.MultipartFile.fromBytes(
        'hero_images',
        _imageBytes!,
        filename: _pickedImage!.name,
      );
    }

    context.read<ProductBloc>().add(UpdateProduct(
          productId: widget.product.id!,
          name: _nameController.text,
          sellingPrice: _sellingPriceController.text,
          categoryId: _selectedCategoryId,
          stock: int.tryParse(_stockController.text) ?? 0,
          isNonStock: _isNonStock,
          initialPrice: _initialPriceController.text,
          unit: _unitController.text,
          heroImage: image,
        ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Product name is required';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _initialPriceController,
              decoration: const InputDecoration(labelText: 'Initial Price'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _sellingPriceController,
              decoration: const InputDecoration(labelText: 'Selling Price'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _stockController,
              decoration: const InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _unitController,
              decoration: const InputDecoration(labelText: 'Unit'),
            ),
            Row(
              children: [
                Checkbox(
                    value: _isNonStock,
                    onChanged: (v) => setState(() => _isNonStock = v!)),
                const Text('Non Stok'),
              ],
            ),
            const SizedBox(height: 12),
            _isLoadingCategory
                ? const CircularProgressIndicator()
                : DropdownButtonFormField<String>(
                    value: _selectedCategoryId.isNotEmpty
                        ? _selectedCategoryId
                        : null,
                    decoration: const InputDecoration(labelText: 'Category'),
                    items: _categories
                        .map((category) => DropdownMenuItem(
                              value: category.id!,
                              child: Text(category.name ?? 'No Name'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategoryId = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Wajib memilih kategori';
                      }
                      return null;
                    },
                  ),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: _pickImage, child: const Text('Change Image')),
            const SizedBox(height: 12),
            _imageBytes != null
                ? Image.memory(
                    _imageBytes!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : const Placeholder(fallbackHeight: 100, fallbackWidth: 100),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: _submit, child: const Text('Save Changes')),
          ],
        ),
      ),
    );
  }
}
