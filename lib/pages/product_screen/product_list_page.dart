import 'package:ecopos/main/bloc/product/product_bloc.dart';
import 'package:ecopos/pages/product_screen/create_product_page.dart';
import 'package:ecopos/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListPage extends StatelessWidget {
  // TODO: Ganti placeholder ini dengan ID Outlet yang sebenarnya dari aplikasi Anda.
  // Ini bisa didapatkan dari data login pengguna, konfigurasi aplikasi, dll.
  final String _currentOutletId = '426c196f-ea5b-4bf1-a084-ad22d087b48c'; // Contoh dari Postman Collection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return Center(child: Text('No products found'));
            }
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      product.hero_images,
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                    ),
                    title: Text(product.name),
                    subtitle: Text(
                      'Stock: ${product.stock}\nInitial Price: Rp ${product.initial_price}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CreateProductPage(product: product),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            context.read<ProductBloc>().add(DeleteProduct(product.id!));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: Text('No products found'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreateProductPage()),
          );

          if (result == true) {
            // Panggil FetchProducts dengan outletId yang benar setelah kembali dari CreateProductPage
            context.read<ProductBloc>().add(FetchProducts(_currentOutletId));
          }
        },
      ),
    );
  }
}
