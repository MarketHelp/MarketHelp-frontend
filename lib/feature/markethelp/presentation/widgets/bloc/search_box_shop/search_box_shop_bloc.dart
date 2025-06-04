import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/shop_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/shop_repository.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_box_shop_event.dart';
part 'search_box_shop_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class SearchBoxShopBloc extends Bloc<SearchBoxShopEvent, SearchBoxShopState> {
  final ShopRepository repository = GetIt.I<ShopRepository>();

  SearchBoxShopBloc()
    : super(SearchBoxShopInitialState(shops: List<ShopEntity>.empty())) {
    on<SearchBoxShopTextChangedEvent>(
      _onSearch,
      transformer: debounceDroppable(const Duration(milliseconds: 300)),
    );

    on<SearchBoxUpdateEvent>((event, emit) => _loadInitialData());

    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final shops = await repository.getShops();
      emit(SearchBoxShopInitialState(shops: shops));
    } catch (e) {
      // Handle error if needed
    }
  }

  void _onSearch(
    SearchBoxShopEvent event,
    Emitter<SearchBoxShopState> emit,
  ) async {
    if (event is SearchBoxShopTextChangedEvent) {
      if (event.text.isEmpty) {
        final shops = await repository.getShops();
        emit(SearchBoxShopInitialState(shops: shops));
        return;
      }

      if (event.text.length < 3) {
        final shops = await repository.getShops();
        emit(SearchBoxShopInitialState(shops: shops));
        return;
      }

      try {
        final shops = await repository.getShops();
        final filteredShops = _filterShop(shops, event.text);
        emit(SearchBoxShopResultState(shops: filteredShops));
      } catch (e) {
        // Handle error if needed
      }
    }
  }

  List<ShopEntity> _filterShop(List<ShopEntity> shops, String text) {
    return shops
        .where((shop) => shop.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }
}
