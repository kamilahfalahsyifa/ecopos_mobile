part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchProducts extends ProductEvent {}

class CreateProduct extends ProductEvent {
  final ProductElement product;
  final http.MultipartFile heroImage;

  const CreateProduct(this.product, this.heroImage);

  @override
  List<Object?> get props => [product, heroImage];
}

class UpdateProduct extends ProductEvent {
  final String productId;
  final String name;
  final String sellingPrice;
  final String categoryId;
  final int stock;
  final bool isNonStock;
  final String initialPrice;
  final String unit;
  final http.MultipartFile? heroImage;

  const UpdateProduct({
    required this.productId,
    required this.name,
    required this.sellingPrice,
    required this.categoryId,
    required this.stock,
    required this.isNonStock,
    required this.initialPrice,
    required this.unit,
    this.heroImage,
  });

  @override
  List<Object?> get props => [
        productId,
        name,
        sellingPrice,
        categoryId,
        stock,
        isNonStock,
        initialPrice,
        unit,
        heroImage,
      ];
}

class DeleteProduct extends ProductEvent {
  final String productId;

  const DeleteProduct(this.productId);

  @override
  List<Object?> get props => [productId];
}
