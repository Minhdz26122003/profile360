import 'package:democart/features/cart/domain/entities/booking_cart.dart';
import 'package:equatable/equatable.dart';

enum SearchType { phoneNumber, booking, customerName }

abstract class CartListState extends Equatable {
  const CartListState();

  @override
  List<Object?> get props => [];
}

class CartListInitial extends CartListState {}

class CartListLoading extends CartListState {}

class CartListLoaded extends CartListState {
  final List<BookingCart> allCarts;
  final List<BookingCart> filteredCarts;
  final String searchQuery;
  final SearchType searchType;

  const CartListLoaded({
    required this.allCarts,
    required this.filteredCarts,
    this.searchQuery = '',
    this.searchType = SearchType.customerName,
  });

  @override
  List<Object?> get props => [allCarts, filteredCarts, searchQuery, searchType];

  CartListLoaded copyWith({
    List<BookingCart>? allCarts,
    List<BookingCart>? filteredCarts,
    String? searchQuery,
    SearchType? searchType,
  }) {
    return CartListLoaded(
      allCarts: allCarts ?? this.allCarts,
      filteredCarts: filteredCarts ?? this.filteredCarts,
      searchQuery: searchQuery ?? this.searchQuery,
      searchType: searchType ?? this.searchType,
    );
  }
}

class CartListError extends CartListState {
  final String message;

  const CartListError(this.message);

  @override
  List<Object?> get props => [message];
}
