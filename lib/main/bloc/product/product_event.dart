part of 'product_bloc.dart';

abstract class ProductEvent {}

class FetchProducts extends ProductEvent {
  final String outletId; // Tambahkan outletId

  FetchProducts(this.outletId);
}

class CreateProduct extends ProductEvent {
  final Product product;

  CreateProduct(this.product);
}

class UpdateProduct extends ProductEvent {
  final String id;
  final Product product;

  UpdateProduct(this.id, this.product);
}

class DeleteProduct extends ProductEvent {
  final String id;

  DeleteProduct(this.id);
}
