part of 'search_box_product_bloc.dart';

@immutable
sealed class SearchBoxProductEvent {}

class SearchBoxProductTextChangedEvent extends SearchBoxProductEvent {
  final String text;

  SearchBoxProductTextChangedEvent(this.text);
}

class SearchBoxProductLoadEvent extends SearchBoxProductEvent {
  final int shopId;

  SearchBoxProductLoadEvent(this.shopId);
}

//TODO: ADD FILTER EVENT
