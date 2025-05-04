part of 'search_box_product_bloc.dart';

@immutable
sealed class SearchBoxProductState {
  final List<ProductEntity> products;
  const SearchBoxProductState({required this.products});
}

class SearchBoxProductInitialState extends SearchBoxProductState {
  const SearchBoxProductInitialState({required List<ProductEntity> products})
    : super(products: products);
}

class SearchBoxProductResultState extends SearchBoxProductState {
  const SearchBoxProductResultState({required List<ProductEntity> products})
    : super(products: products);
}
