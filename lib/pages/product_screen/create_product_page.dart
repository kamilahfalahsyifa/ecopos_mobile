import 'dart:convert';
import 'dart:typed_data';
// import 'package:http_parser/http_parser.dart'; // Tidak diperlukan lagi jika menggunakan JSON
import 'package:ecopos/config/ColorConfig.dart';
import 'package:ecopos/main/bloc/product/product_bloc.dart';
import 'package:ecopos/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';

class CreateProductPage extends StatefulWidget {
  final Product? product;

  CreateProductPage({this.product});

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _unitController = TextEditingController();
  final _categoryController = TextEditingController();
  final _initialPriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _outletIdController = TextEditingController(); // Controller untuk Outlet ID
  bool _isNonStock = false;

  Uint8List? _imageData;
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _stockController.text = widget.product!.stock.toString();
      _unitController.text = widget.product!.unit;
      _categoryController.text = widget.product!.category_id;
      _initialPriceController.text = widget.product!.initial_price.toString();
      _sellingPriceController.text = widget.product!.selling_price.toString();
      _outletIdController.text = widget.product!.outlet_id;
      _isNonStock = widget.product!.is_non_stock;
      // Jika ada produk yang diedit dan memiliki gambar, tampilkan gambar tersebut
      if (widget.product!.hero_images.isNotEmpty && !widget.product!.hero_images.startsWith('http')) {
        try {
          _imageData = base64Decode(widget.product!.hero_images);
          _base64Image = widget.product!.hero_images;
        } catch (e) {
          print('Error decoding existing base64 image: $e');
        }
      }
    } else {
      // TODO: Inisialisasi outlet_id untuk produk baru jika ada default atau dari context
      // Misalnya, jika Anda memiliki ID outlet yang tersedia secara global atau dari pengguna yang login
      // _outletIdController.text = 'default_outlet_id_here';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _stockController.dispose();
    _unitController.dispose();
    _categoryController.dispose();
    _initialPriceController.dispose();
    _sellingPriceController.dispose();
    _outletIdController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final fromPicker = await ImagePickerWeb.getImageAsBytes();
    if (fromPicker != null) {
      setState(() {
        _imageData = fromPicker;
        _base64Image = base64Encode(fromPicker);
      });
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _hideLoadingDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi semua bidang yang wajib diisi dengan benar.')),
      );
      return;
    }

    _showLoadingDialog();

    try {
      final product = Product(
        id: widget.product?.id, // Pertahankan ID jika ini adalah update
        name: _nameController.text,
        selling_price: int.parse(_sellingPriceController.text),
        category_id: _categoryController.text,
        outlet_id: _outletIdController.text, // Pastikan ini diisi
        stock: int.parse(_stockController.text),
        is_non_stock: _isNonStock,
        initial_price: int.parse(_initialPriceController.text),
        unit: _unitController.text,
        hero_images: _base64Image ?? widget.product?.hero_images ?? "",
      );

      if (widget.product == null) {
        context.read<ProductBloc>().add(CreateProduct(product));
      } else {
        context.read<ProductBloc>().add(UpdateProduct(widget.product!.id!, product));
      }

      final blocState = await context.read<ProductBloc>().stream.firstWhere(
        (state) => state is ProductLoaded || state is ProductError
      );

      _hideLoadingDialog();

      if (blocState is ProductLoaded) {
        Navigator.pop(context, true);
      } else if (blocState is ProductError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan data: ${blocState.message}')),
        );
      }

    } catch (e) {
      _hideLoadingDialog();
      print('Error in _handleSubmit: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product == null ? 'Create Product' : 'Edit Product'), backgroundColor: ColorConfig.bgLight,),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: "Stock"),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Wajib diisi";
                  }
                  if (int.tryParse(val) == null) {
                    return "Harus angka";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _unitController,
                decoration: InputDecoration(labelText: "Unit"),
                validator: (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: "Category ID"),
                validator: (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: _initialPriceController,
                decoration: InputDecoration(labelText: "Initial Price"),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Wajib diisi";
                  }
                  if (int.tryParse(val) == null) {
                    return "Harus angka";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sellingPriceController,
                decoration: InputDecoration(labelText: "Selling Price"),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Wajib diisi";
                  }
                  if (int.tryParse(val) == null) {
                    return "Harus angka";
                  }
                  return null;
                },
              ),
              // Tambahkan TextFormField untuk Outlet ID
              TextFormField(
                controller: _outletIdController,
                decoration: InputDecoration(labelText: "Outlet ID"),
                validator: (val) => val == null || val.isEmpty ? "Wajib diisi" : null,
              ),
              CheckboxListTile(
                value: _isNonStock,
                onChanged: (val) => setState(() => _isNonStock = val!),
                title: Text('Non Stock'),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Upload Gambar'),
              ),
              if (_imageData != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image.memory(_imageData!, height: 150),
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text(widget.product == null ? "Create" : "Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
