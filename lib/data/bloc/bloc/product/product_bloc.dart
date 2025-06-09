import 'package:bloc/bloc.dart';
import 'package:ecopos/pages/product/datasource/product_remote_datasource.dart';
import 'package:ecopos/pages/product/models/product_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource remoteDatasource;

  ProductBloc({required this.remoteDatasource}) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<CreateProduct>(_onCreateProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final response = await remoteDatasource.getProduct();
    if (response['success']) {
      final jsonList = response['data']['products'] as List<dynamic>;
      final products = jsonList
          .map((json) => ProductElement.fromJson(json))
          .toList();
      emit(ProductLoaded(products));
    } else {
      emit(ProductError(response['message']));
    }
  }

  Future<void> _onCreateProduct(
      CreateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final response =
        await remoteDatasource.createProduct(event.product, event.heroImage);
    if (response['success']) {
      add(FetchProducts());
    } else {
      emit(ProductError(response['message']));
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final response = await remoteDatasource.updateProduct(
      product_id: event.productId,
      name: event.name,
      selling_price: event.sellingPrice,
      category_id: event.categoryId,
      stock: event.stock,
      is_non_stock: event.isNonStock,
      initial_price: event.initialPrice,
      unit: event.unit,
      hero_image: event.heroImage,
    );
    if (response['success']) {
      add(FetchProducts());
    } else {
      emit(ProductError(response['message']));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    // TODO: Implement deleteProduct in remoteDatasource
    // await remoteDatasource.deleteProduct(event.productId);
    // For now, let's just simulate success:
    await Future.delayed(const Duration(seconds: 1));
    add(FetchProducts());
  }
}