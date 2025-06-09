import 'dart:io';
import 'dart:typed_data';

import 'package:ecopos/pages/category/datasource/category_remote_datasouce.dart';
import 'package:ecopos/pages/product/models/product_response_model.dart';
import 'package:ecopos/data/bloc/bloc/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _initialPriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _unitController = TextEditingController();
  final _stockController = TextEditingController();
  bool _isNonStock = false;
  String _selectedCategoryId = '';
  XFile? _pickedImage;
  Uint8List? _imageBytes;

  List<Category> _categories = [];
  bool _isLoadingCategory = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() async {
    try {
      final data = await CategoryRemoteDatasource().fetchCategories();
      setState(() {
        _categories = data;
        _isLoadingCategory = false;
        if (_categories.isNotEmpty) {
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
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _pickedImage = picked;
      if (kIsWeb) {
        _imageBytes = await picked.readAsBytes();
      } else {
        _imageBytes = await File(picked.path).readAsBytes();
      }
      setState(() {});
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate() && _pickedImage != null) {
      final bytes = await _pickedImage!.readAsBytes();
      final multipartImage = http.MultipartFile.fromBytes(
        'hero_images',
        bytes,
        filename: _pickedImage!.name,
      );

      final product = ProductElement(
        name: _nameController.text,
        initialPrice: _initialPriceController.text,
        sellingPrice: _sellingPriceController.text,
        stock: int.tryParse(_stockController.text) ?? 0,
        isNonStock: _isNonStock,
        unit: _unitController.text,
        categoryId: _selectedCategoryId,
      );

      context.read<ProductBloc>().add(CreateProduct(product, multipartImage));
      Navigator.pop(context);
    } else if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product image is required')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Product')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
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
                    onChanged: (v) => setState(() => _isNonStock = v!),
                  ),
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
                      decoration:
                          const InputDecoration(labelText: 'Category'),
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
                onPressed: _pickImage,
                child: const Text('Select Image'),
              ),
              const SizedBox(height: 8),
              _imageBytes != null
                  ? Image.memory(
                      _imageBytes!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : const Placeholder(
                      fallbackWidth: 100,
                      fallbackHeight: 100,
                    ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
