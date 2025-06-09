import 'package:ecopos/config/ColorConfig.dart';
import 'package:ecopos/data/bloc/bloc/product/product_bloc.dart';
import 'package:ecopos/pages/product/create_product_page.dart';
import 'package:ecopos/pages/product/edit_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.bgLight,
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConfig.textDark,
            fontSize: 24,
          ),
        ),
        backgroundColor: ColorConfig.bgLight,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ProductBloc>().add(FetchProducts());
            },
          )
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else if (state is ProductLoaded) {
            final products = state.products;
            if (products.isEmpty) {
              return const Center(child: Text('No products yet.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                String imageUrl;
                if (product.heroImages == null) {
                  imageUrl = 'https://via.placeholder.com/150';
                } else if (product.heroImages!.startsWith('http')) {
                  imageUrl = product.heroImages!;
                } else {
                  imageUrl =
                      'https://tannn.my.id/storage/${product.heroImages!}';
                }

                return Card(
                  color: ColorConfig.bgSbtle,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.broken_image, size: 60);
                        },
                      ),
                    ),
                    title: Text(product.name ?? 'Tanpa Nama'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Selling Price: Rp ${product.sellingPrice ?? '0'}'),
                        Text(
                            'Stock: ${product.stock ?? 0} ${product.unit ?? ''}'),
                        Text('Category: ${product.category?.name ?? '-'}'),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    EditProductPage(product: product)),
                          );
                        } else if (value == 'delete') {
                          context
                              .read<ProductBloc>()
                              .add(DeleteProduct(product.id!));
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(
                            value: 'delete', child: Text('Delete')),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink(); // fallback
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConfig.mainBlue,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CreateProductPage()));
        },
        child: const Icon(
          Icons.add,
          color: ColorConfig.textLight,
        ),
      ),
    );
  }
}
