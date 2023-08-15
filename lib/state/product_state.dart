import 'package:equatable/equatable.dart';

abstract class ProductState extends Equatable {
  final List<String>? defaultItems;
  final List<String>? payItems;

  const ProductState({
    this.defaultItems,
    this.payItems,
  });
}

class InitProductState extends ProductState {
  InitProductState()
      : super(
          defaultItems: [],
          payItems: [],
        );

  @override
  List<Object?> get props => [defaultItems, payItems];
}

class LoadingProductState extends ProductState {
  const LoadingProductState({
    super.defaultItems,
    super.payItems,
  });

  @override
  List<Object?> get props => [defaultItems, payItems];
}

class LoadedProductState extends ProductState {
  const LoadedProductState({
    super.defaultItems,
    super.payItems,
  });

  @override
  List<Object?> get props => [defaultItems, payItems];
}

class ErrorProductState extends ProductState {
  final String errorMessage;

  const ErrorProductState(this.errorMessage);

  @override
  List<Object?> get props => [];
}
