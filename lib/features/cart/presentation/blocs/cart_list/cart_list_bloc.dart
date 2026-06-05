import 'package:democart/features/cart/domain/entities/booking_cart.dart';
import 'package:democart/features/cart/domain/entities/service_item.dart';
import 'package:democart/features/cart/presentation/blocs/cart_list/cart_list_event.dart';
import 'package:democart/features/cart/presentation/blocs/cart_list/cart_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  CartListBloc() : super(CartListInitial()) {
    on<LoadCartList>(_onLoadCartList);
    on<RefreshCartList>(_onRefreshCartList);
    on<SearchCartList>(_onSearchCartList);
    on<UpdateSearchType>(_onUpdateSearchType);
  }

  final List<BookingCart> _mockCarts = [
    const BookingCart(
      id: 'BOOK-260522-00005',
      customerName: 'NGUYỄN KHÁNH HƯƠNG GIANG',
      phoneNumber: '0987654321',
      items: [
        ServiceItem(name: 'Cạo vôi răng & đánh bóng - Mức độ 1', quantity: 1),
        ServiceItem(name: 'Trụ Implant Hàn Quốc - Dentium', quantity: 2),
      ],
      totalPrice: 25750000,
      source: 'K - CTV nội bộ',
      status: 'Hiệu lực',
    ),
    const BookingCart(
      id: 'BOOK-260525-00006',
      customerName: 'NGUYỄN KHÁNH HƯƠNG GIANG',
      phoneNumber: '0987654321',
      items: [ServiceItem(name: 'Trụ Implant Hàn Quốc - Dentium', quantity: 1)],
      totalPrice: 16000000,
      source: 'MD - Affiliate',
      status: 'Hiệu lực',
    ),
    const BookingCart(
      id: 'BOOK-260528-00007',
      customerName: 'PHẠM MINH QUÂN',
      phoneNumber: '0912345678',
      items: [
        ServiceItem(name: 'Tẩy trắng răng bằng đèn Plasma', quantity: 1),
        ServiceItem(name: 'Trám răng thẩm mỹ', quantity: 2),
      ],
      totalPrice: 4200000,
      source: 'K - CTV nội bộ',
      status: 'Hiệu lực',
    ),
    const BookingCart(
      id: 'BOOK-260530-00008',
      customerName: 'LÊ THỊ HOÀI',
      phoneNumber: '0905556677',
      items: [ServiceItem(name: 'Nhổ răng khôn mọc lệch', quantity: 1)],
      totalPrice: 2500000,
      source: 'MD - Affiliate',
      status: 'Hiệu lực',
    ),
    const BookingCart(
      id: 'BOOK-260525-00007',
      customerName: 'NGUYỄN QUANG TÙNG',
      phoneNumber: '0987654321',
      items: [
        ServiceItem(name: 'Trụ Implant Hàn Quốc - Dentium', quantity: 1),
        ServiceItem(name: 'Trám răng thẩm mỹ', quantity: 2),
        ServiceItem(name: 'Trám răng thẩm mỹ 2', quantity: 1),
      ],
      totalPrice: 16000000,
      source: 'MD - Affiliate',
      status: 'Hiệu lực',
    ),
  ];

  void _onLoadCartList(LoadCartList event, Emitter<CartListState> emit) async {
    emit(CartListLoading());
    await Future.delayed(const Duration(milliseconds: 800));
    emit(
      CartListLoaded(
        allCarts: List.from(_mockCarts),
        filteredCarts: List.from(_mockCarts),
      ),
    );
  }

  void _onRefreshCartList(
    RefreshCartList event,
    Emitter<CartListState> emit,
  ) async {
    final currentState = state;
    String currentQuery = '';
    SearchType currentType = SearchType.customerName;
    if (currentState is CartListLoaded) {
      currentQuery = currentState.searchQuery;
      currentType = currentState.searchType;
    }
    emit(CartListLoading());
    await Future.delayed(const Duration(milliseconds: 600));

    for (int i = 0; i < _mockCarts.length; i++) {
      _mockCarts[i] = _mockCarts[i].copyWith(status: 'Hiệu lực');
    }

    final filtered = _filterCarts(_mockCarts, currentQuery, currentType);
    emit(
      CartListLoaded(
        allCarts: List.from(_mockCarts),
        filteredCarts: filtered,
        searchQuery: currentQuery,
        searchType: currentType,
      ),
    );
  }

  void _onSearchCartList(SearchCartList event, Emitter<CartListState> emit) {
    final currentState = state;
    if (currentState is CartListLoaded) {
      final filtered = _filterCarts(
        currentState.allCarts,
        event.query,
        currentState.searchType,
      );
      emit(
        currentState.copyWith(
          filteredCarts: filtered,
          searchQuery: event.query,
        ),
      );
    }
  }

  void _onUpdateSearchType(
    UpdateSearchType event,
    Emitter<CartListState> emit,
  ) {
    final currentState = state;
    if (currentState is CartListLoaded) {
      final filtered = _filterCarts(
        currentState.allCarts,
        currentState.searchQuery,
        event.searchType,
      );
      emit(
        currentState.copyWith(
          searchType: event.searchType,
          filteredCarts: filtered,
        ),
      );
    }
  }

  List<BookingCart> _filterCarts(
    List<BookingCart> carts,
    String query,
    SearchType type,
  ) {
    if (query.isEmpty) return List.from(carts);
    final lowercaseQuery = query.toLowerCase();
    return carts.where((cart) {
      switch (type) {
        case SearchType.phoneNumber:
          return cart.phoneNumber.contains(lowercaseQuery);
        case SearchType.booking:
          return cart.id.toLowerCase().contains(lowercaseQuery);
        case SearchType.customerName:
          return cart.customerName.toLowerCase().contains(lowercaseQuery);
      }
    }).toList();
  }
}
