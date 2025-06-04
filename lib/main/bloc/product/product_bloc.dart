import 'package:bloc/bloc.dart';
import 'package:ecopos/models/product_model.dart';
import 'package:ecopos/services/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;

  ProductBloc(this.productService) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        // Gunakan event.outletId saat memanggil fetchProducts
        final products = await productService.fetchProducts(event.outletId);
        emit(ProductLoaded(products));
      } catch (e) {
        print('Error fetching products: $e');
        emit(ProductError("Failed to load products: $e"));
      }
    });

    on<CreateProduct>((event, emit) async {
      try {
        await productService.createProduct(event.product);
        // Setelah berhasil membuat, panggil FetchProducts untuk memperbarui daftar
        // Pastikan product.outlet_id tidak null saat memanggil FetchProducts
        if (event.product.outlet_id.isNotEmpty) {
          add(FetchProducts(event.product.outlet_id));
        } else {
          print('Warning: outlet_id is empty for FetchProducts after creation.');
          // Anda mungkin ingin menangani kasus ini, misalnya dengan me-reload semua produk
          // atau menampilkan pesan error.
        }
      } catch (e) {
        print('Error creating product: $e');
        emit(ProductError("Failed to create product: $e"));
      }
    });

    on<UpdateProduct>((event, emit) async {
      try {
        await productService.updateProduct(event.id, event.product);
        // Setelah berhasil update, panggil FetchProducts untuk memperbarui daftar
        if (event.product.outlet_id.isNotEmpty) {
          add(FetchProducts(event.product.outlet_id));
        } else {
          print('Warning: outlet_id is empty for FetchProducts after update.');
        }
      } catch (e) {
        print('Error updating product: $e');
        emit(ProductError("Failed to update product: $e"));
      }
    });

    on<DeleteProduct>((event, emit) async {
      try {
        await productService.deleteProduct(event.id);
        // Setelah berhasil delete, panggil FetchProducts untuk memperbarui daftar
        // Anda perlu tahu outletId yang relevan di sini.
        // Jika tidak ada cara untuk mendapatkannya, mungkin perlu strategi refresh yang berbeda.
        // Untuk sementara, kita bisa memicu fetch ulang semua produk jika outletId tidak tersedia.
        // Atau, Anda bisa menambahkan outletId ke event DeleteProduct.
        // Untuk demo ini, kita akan mengasumsikan outletId bisa didapatkan atau menggunakan placeholder.
        // Contoh: Jika Anda hanya mengelola produk dari satu outlet, Anda bisa hardcode di sini.
        // Atau, jika ProductState selalu memiliki daftar produk, Anda bisa mencoba mengambil outletId dari produk yang dihapus.
        // Untuk saat ini, kita akan menggunakan placeholder yang sama dengan ProductListPage.
        add(FetchProducts('426c196f-ea5b-4bf1-a084-ad22d087b48c')); // <--- Ganti dengan outletId yang benar
      } catch (e) {
        print('Error deleting product: $e');
        emit(ProductError("Failed to delete product: $e"));
      }
    });
  }
}
