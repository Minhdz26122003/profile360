import 'package:democart/features/cart/presentation/blocs/cart_list/cart_list_state.dart';
import 'package:equatable/equatable.dart';

abstract class CartListEvent extends Equatable {
  const CartListEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartList extends CartListEvent {}

class RefreshCartList extends CartListEvent {}

class SearchCartList extends CartListEvent {
  final String query;

  const SearchCartList(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateSearchType extends CartListEvent {
  final SearchType searchType;

  const UpdateSearchType(this.searchType);

  @override
  List<Object?> get props => [searchType];
}
