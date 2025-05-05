import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/product_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/product_repository.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_box_product_event.dart';
part 'search_box_product_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.debounce(duration), mapper);
  };
}

class SearchBoxProductBloc
    extends Bloc<SearchBoxProductEvent, SearchBoxProductState> {
  final ProductRepository repository = GetIt.I<ProductRepository>();
  String shopId = "";
  List<ProductEntity> currentProducts = List<ProductEntity>.empty();

  SearchBoxProductBloc()
    : super(
        SearchBoxProductInitialState(products: List<ProductEntity>.empty()),
      ) {
    on<SearchBoxProductTextChangedEvent>(
      _onSearch,
      transformer: debounceDroppable(const Duration(milliseconds: 300)),
    );

    on<SearchBoxProductLoadEvent>((event, emit) async {
      shopId = event.shopId;
      _loadInitialData();
    });
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      currentProducts = await repository.getProducts(shopId);
      emit(SearchBoxProductInitialState(products: currentProducts));
    } catch (e) {
      // Handle error if needed
    }
  }

  void _onSearch(
    SearchBoxProductEvent event,
    Emitter<SearchBoxProductState> emit,
  ) async {
    if (event is SearchBoxProductTextChangedEvent) {
      if (event.text.isEmpty) {
        emit(SearchBoxProductInitialState(products: currentProducts));
        return;
      }

      if (event.text.length < 3) {
        emit(SearchBoxProductInitialState(products: currentProducts));
        return;
      }

      try {
        final filteredProducts = _filterProduct(currentProducts, event.text);
        emit(SearchBoxProductResultState(products: filteredProducts));
      } catch (e) {
        // Handle error if needed
      }
    }
  }

  List<ProductEntity> _filterProduct(
    List<ProductEntity> products,
    String text,
  ) {
    return products.where((product) {
      return product.name.toLowerCase().contains(text.toLowerCase());
    }).toList();
  }
}
