part of 'search_box_product_bloc.dart';

@immutable
sealed class SearchBoxProductEvent {}

class SearchBoxProductTextChangedEvent extends SearchBoxProductEvent {
  final String text;

  SearchBoxProductTextChangedEvent(this.text);
}

//TODO: ADD FILTER EVENT
