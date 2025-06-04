part of 'search_box_shop_bloc.dart';

@immutable
sealed class SearchBoxShopState {
  final List<ShopEntity> shops;
  const SearchBoxShopState({required this.shops});
}

class SearchBoxShopInitialState extends SearchBoxShopState {
  const SearchBoxShopInitialState({required List<ShopEntity> shops})
    : super(shops: shops);
}

class SearchBoxShopResultState extends SearchBoxShopState {
  const SearchBoxShopResultState({required List<ShopEntity> shops})
    : super(shops: shops);
}
