part of 'search_box_shop_bloc.dart';

@immutable
sealed class SearchBoxShopEvent {}

class SearchBoxShopTextChangedEvent extends SearchBoxShopEvent {
  final String text;

  SearchBoxShopTextChangedEvent(this.text);
}
